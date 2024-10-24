class ImageCoresController < ApplicationController
  before_action :set_image_core, only: %i[ show edit update destroy ]

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

    puts "image_update_params --> #{image_update_params}"
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
      # destroy image tags before update

      permitted_params = params.require(:image_core).permit(:description, image_tags_attributes: [:name, :_destroy])
      
      # Convert names TagName ids
      if permitted_params[:image_tags_attributes].present?
        tag_names = permitted_params[:image_tags_attributes].values.map {|item| item[:name]}
        tag_names = tag_names[0].split(",").map {|name| name.strip}
        tag_names = tag_names.map {|name| TagName.find_by({name: name})} #.map {|result| result.id}
        # tag_names.each do |tag_name|
        #   puts "tag_name -> #{tag_name}"
        #   @image_core.image_tags.new({tag_name: tag_name})
        # end
        # puts "all tags --> #{@image_core.image_tags}"
        permitted_params.delete(:image_tags_attributes)

        tag_names_hash = tag_names.map {|tag| {tag_name: tag}}
        permitted_params[:image_tags_attributes] = tag_names_hash
        # puts "permitted_params -> #{permitted_params}"
      end

      permitted_params

    end
end
