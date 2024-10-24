class ImageCoresController < ApplicationController
  rate_limit to: 20, within: 1.minute, only: [ :search ], with: -> { redirect_to root_path, alert: "Too many requests. Please try again" }
  before_action :set_image_core, only: %i[ show edit update destroy ]

  def search
  end

  def search_items
    @query = search_params["query"]
    @checkbox_value = "0" #search_params["checkbox_value"]
    if @checkbox_value == "0" # keyword
      @query = remove_stopwords(@query)
      @image_cores = ImageCore.search_any_word(@query).limit(10) || []
    end
    if @checkbox_value == "1" # vector
      @image_cores = vector_search(@query)
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
    @image_cores = ImageCore.order(created_at: :desc)
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

    respond_to do |format|
      if @image_core.update(image_update_params)
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
    # Use callbacks to share common setup or constraints between actions.
    def set_image_core
      @image_core = ImageCore.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def image_core_params
      params.require(:image_core).permit(:description)
    end

    def image_update_params
      permitted_params = params.require(:image_core).permit(:description, image_tags_attributes: [:name, :_destroy])
      
      # Convert names TagName ids
      if permitted_params[:image_tags_attributes].present?
        tag_names = permitted_params[:image_tags_attributes].values.map {|item| item[:name]}
        tag_names = tag_names[0].split(",").map {|name| name.strip}
        tag_names = tag_names.map {|name| TagName.find_by({name: name})} #.map {|result| result.id}
        tag_names_hash = tag_names.map {|tag| {tag_name: tag}}
        permitted_params.delete(:image_tags_attributes)
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
    params.permit([ :query, :checkbox_value, :authenticity_token, :source, :controller, :action ])
  end

end
