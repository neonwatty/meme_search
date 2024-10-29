require 'uri'
require 'net/http'
require 'json'

class ImageCoresController < ApplicationController
  rate_limit to: 20, within: 1.minute, only: [ :search ], with: -> { redirect_to root_path, alert: "Too many requests. Please try again" }
  before_action :set_image_core, only: %i[ show edit update destroy generate ]
  skip_before_action :verify_authenticity_token, only: [ :done_receiver, :status_receiver ]

  def status_receiver
    received_data = params[:data]
    id = received_data[:image_core_id].to_i
    status = received_data[:status].to_i
    image = ImageCore.find(id)
    image.status = status
    image.save
  end

  def done_receiver
    received_data = params[:data]
    id = received_data[:image_core_id].to_i
    description = received_data[:description]

    image = ImageCore.find(id)
    image.description = description
    image.status = 3

    if image.save
      puts "Description updated successfully."
    else
      puts "Error updating description: #{image.errors.full_messages.join(", ")}"
    end    
    render json: { received: received_data }, status: :ok
  end

  def generate
    status = @image_core.status
    if status != 0 && status != 4
      # update status of instance
      @image_core.status = 1
      @image_core.save

      # send request
      puts "INFO: starting"
      uri = URI('http://localhost:8000/add_job')
      http = Net::HTTP.new(uri.host, uri.port)

      request = Net::HTTP::Post.new(uri)
      request['Content-Type'] = 'application/json'
      data = { image_core_id: @image_core.id, image_path: @image_core.image_path.name + "/" + @image_core.name }  
      request.body = data.to_json
      response = http.request(request)
      puts response.body

      respond_to do |format|
        if response.is_a?(Net::HTTPSuccess)
          puts response.body
          flash[:notice] = "Image added to queue for automatic description generation."
          format.html { redirect_to @image_core }
        else
          puts "Error: #{response.code} - #{response.message}"
        end
      end
    else
      respond_to do |format|
        flash[:notice] = "Image currently in queue for text description generation."
        format.html { redirect_to @image_core }
      end
    end
  end

  def search
  end

  def search_items
    selected_tag_names = search_params[:selected_tag_names]
    search_params.delete(:selected_tag_names)

    @query = search_params["query"]
    @checkbox_value = search_params["checkbox_value"]
    if @checkbox_value == "0" # keyword
      @query = remove_stopwords(@query)
      @image_cores = ImageCore.search_any_word(@query).limit(10) || []
    end
    if @checkbox_value == "1" # vector
      @image_cores = vector_search(@query)
    end

    # filter search results via selected tags
    if selected_tag_names.length > 0
      @image_cores = @image_cores.select {|item| (item.image_tags&.map { |tag| tag.tag_name&.name } & selected_tag_names).any?}
    end

    respond_to do |format|
      # resopnd to turbo
      format.turbo_stream do
        if @query.blank?
          render turbo_stream: turbo_stream.update("search_results", partial: "image_cores/no_search")
        else
          render turbo_stream: turbo_stream.update("search_results", partial: "image_cores/search_results", locals: { image_cores: @image_cores, query: @query })
        end
      end

      # Handle HTML format or other formats
      format.html do
        # Redirect or render a specific view if needed
      end

      # Optionally handle other formats like JSON
      format.json { render json: @words }
    end
  end

  # GET /image_cores
  def index
    if params[:selected_tag_names].present?
      selected_tag_names = params[:selected_tag_names].split(",").map {|tag| tag.strip}
      @image_cores = ImageCore.with_selected_tag_names(selected_tag_names)
    else
      @image_cores = ImageCore.order(created_at: :desc)
    end
    @pagy, @image_cores = pagy(@image_cores)


  end

  # GET /image_cores/1
  def show
  end

  # GET /image_cores/new
  # def new
  #   @image_core = ImageCore.new
  # end

  # GET /image_cores/1/edit
  def edit
    @image_core = ImageCore.find(params[:id])
    @image_core.image_tags.build if @image_core.image_tags.empty?
  end

  # POST /image_cores or /image_cores.json
  # def create
  #   @image_core = ImageCore.new(image_core_params)

  #   respond_to do |format|
  #     if @image_core.save
  #       flash[:notice] = "Image data was successfully created."
  #       format.html { redirect_to @image_core }
  #     else
  #       flash[:alert] = @image_core.errors.full_messages[0]
  #       format.html { render :new, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # PATCH/PUT /image_cores/1 or /image_cores/1.json
  def update
    image_tags = @image_core.image_tags.map {|tag| tag.id}
    image_tags.each do |tag|
      ImageTag.destroy(tag)
    end

    # check if description has changed to update status
    update_params = image_update_params

    puts "params --> #{params}"
    puts "update_params --> #{update_params}"

    respond_to do |format|
      if @image_core.update(update_params)
        flash[:notice] = "Image data was updated succesfully."
        format.html { redirect_to @image_core }
      else
        flash[:alert] = @image_core.errors.full_messages[0]
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /image_cores/1 or /image_cores/1.json
  def destroy
    @image_core.destroy!

    respond_to do |format|
      flash[:notice] = "Image data was successfully destroyed."
      format.html { redirect_to image_cores_path, status: :see_other }
    end
  end

  private

    def vector_search(query)
      query_embedding = ImageEmbedding.new({image_core_id:ImageCore.first.id, snippet: query})
      query_embedding.compute_embedding;
      results = query_embedding.get_neighbors.map {|item| item.image_core_id}.uniq.map {|image_core_id| ImageCore.find(image_core_id)}
      return results
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_image_core
      @image_core = ImageCore.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def image_core_params
      params.require(:image_core).permit(:description)
    end

    def image_update_params
      puts "permitted_params --> #{params}"
      permitted_params = params.require(:image_core).permit(:description, :selected_tag_names, :status, image_tags_attributes: [:id, :name, :_destroy])
      
      # Convert names TagName ids
      if permitted_params[:selected_tag_names].present?
        tag_names = permitted_params[:selected_tag_names]
        tag_names = tag_names.split(",").map {|name| name.strip}

        tag_names = tag_names.map {|name| TagName.find_by({name: name})} #.map {|result| result.id}
        tag_names_hash = tag_names.map {|tag| {tag_name: tag}}
        if tag_names_hash[0][:tag_name].nil?
          tag_names_hash = []
        end
        permitted_params.delete(:image_tags_attributes)
        permitted_params.delete(:selected_tag_names)

        permitted_params[:image_tags_attributes] = tag_names_hash
      end

      permitted_params
    end

  def remove_stopwords(input_string)
    stopwords = %w[a i me my myself we our ours ourselves you your yours yourself yourselves he him his himself she her hers herself it its itself they them their theirs themselves what which who whom this that these those am is are was were be been being have has had having do does did doing a an the and but if or as until while of at by for with above below to from up down in out on off over under how all any both each few more most other some such no nor not only own same so than too very s]

    words = input_string.split
    filtered_words = words.reject { |word| stopwords.include?(word.downcase) }
    
    filtered_words.join(' ')
  end

  def search_params
    permitted_params = params.permit([:query, :checkbox_value, :authenticity_token, :source, :controller, :action, :selected_tag_names, search_tags: [:tag] ])
    permitted_params.delete(:search_tags)
    selected_tag_names = permitted_params[:selected_tag_names].split(",").map {|tag| tag.strip}
    permitted_params.delete(:selected_tag_names)
    permitted_params[:selected_tag_names] = selected_tag_names
    puts "CHECKBOX --> #{permitted_params[:checkbox_value]}"
    return permitted_params
  end

end
