class ImagePathsController < ApplicationController
  before_action :set_image_path, only: %i[ show edit update destroy ]

  # GET /image_paths
  def index
    @image_paths = ImagePath.order(created_at: :desc)
    @pagy, @image_paths = pagy(@image_paths)
  end

  # GET /image_paths/1
  def show
  end

  # GET /image_paths/new
  def new
    @image_path = ImagePath.new
  end

  # GET /image_paths/1/edit
  def edit
  end

  # POST /image_paths
  def create
    @image_path = ImagePath.new(image_path_params)
    respond_to do |format|
      if @image_path.save
        flash[:notice] = "Image path was successfully created."
        format.html { redirect_to @image_path }
      else
        flash[:alert] = @image_path.errors.full_messages[0]
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /image_paths/1
  def update
    respond_to do |format|
      if @image_path.update(image_path_params)
        flash[:notice] = "Image path was updated succesfully."
        format.html { redirect_to @image_path, notice: "Image path was successfully updated." }
      else
        flash[:alert] = @image_path.errors.full_messages[0]
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /image_paths/1
  def destroy
    @image_path.destroy!

    respond_to do |format|
      flash[:notice] = "Image path was successfully destroyed."
      format.html { redirect_to image_paths_path, status: :see_other }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image_path
      @image_path = ImagePath.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def image_path_params
      params.require(:image_path).permit(:name)
    end
end
