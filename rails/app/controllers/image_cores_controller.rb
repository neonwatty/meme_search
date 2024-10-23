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
  end

  # POST /image_cores or /image_cores.json
  # def create
  #   @image_core = ImageCore.new(image_core_params)

  #   respond_to do |format|
  #     if @image_core.save
  #       flash[:notice] = "Image data was successfully created."
  #       format.html { redirect_to @image_core }
  #     else
  #       flash[:alert] = @image_path.errors.full_messages[0]
  #       format.html { render :new, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # PATCH/PUT /image_cores/1 or /image_cores/1.json
  def update
    respond_to do |format|
      if @image_core.update(image_core_params)
        flash[:notice] = "Image data was updated succesfully."
        format.html { redirect_to @image_core }
      else
        flash[:alert] = @image_path.errors.full_messages[0]
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
end
