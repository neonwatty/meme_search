class ImagePathsController < ApplicationController
  before_action :set_image_path, only: %i[ show edit update destroy ]

  # GET /image_paths or /image_paths.json
  def index
    @image_paths = ImagePath.all
  end

  # GET /image_paths/1 or /image_paths/1.json
  def show
  end

  # GET /image_paths/new
  def new
    @image_path = ImagePath.new
  end

  # GET /image_paths/1/edit
  def edit
  end

  # POST /image_paths or /image_paths.json
  def create
    @image_path = ImagePath.new(image_path_params)

    respond_to do |format|
      if @image_path.save
        format.html { redirect_to @image_path, notice: "Image path was successfully created." }
        format.json { render :show, status: :created, location: @image_path }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @image_path.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /image_paths/1 or /image_paths/1.json
  def update
    respond_to do |format|
      if @image_path.update(image_path_params)
        format.html { redirect_to @image_path, notice: "Image path was successfully updated." }
        format.json { render :show, status: :ok, location: @image_path }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @image_path.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /image_paths/1 or /image_paths/1.json
  def destroy
    @image_path.destroy!

    respond_to do |format|
      format.html { redirect_to image_paths_path, status: :see_other, notice: "Image path was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image_path
      @image_path = ImagePath.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def image_path_params
      params.require(:image_path).permit(:image_path)
    end
end
