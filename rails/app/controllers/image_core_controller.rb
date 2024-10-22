class ImageCoreController < ApplicationController
  before_action :set_image_core, only: %i[ show edit update destroy ]

  # GET /image_cores or /image_cores.json
  def index
    @image_cores = ImageCore.all
  end

  # GET /image_cores/1 or /image_cores/1.json
  def show
  end

  # GET /image_cores/new
  def new
    @image_core = ImageCore.new
  end

  # GET /image_cores/1/edit
  def edit
  end

  # POST /image_cores or /image_cores.json
  def create
    @image_core = ImageCore.new(image_core_params)

    respond_to do |format|
      if @image_core.save
        format.html { redirect_to @image_core, notice: "ImageCore was successfully created." }
        format.json { render :show, status: :created, location: @image_core }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @image_core.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /image_cores/1 or /image_cores/1.json
  def update
    respond_to do |format|
      if @image_core.update(image_core_params)
        format.html { redirect_to @image_core, notice: "ImageCore was successfully updated." }
        format.json { render :show, status: :ok, location: @image_core }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @image_core.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /image_cores/1 or /image_cores/1.json
  def destroy
    @image_core.destroy!

    respond_to do |format|
      format.html { redirect_to image_cores_path, status: :see_other, notice: "ImageCore was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image_core
      @image_core = ImageCore.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def image_core_params
      params.require(:image_name).permit(:image_description)
    end
end
