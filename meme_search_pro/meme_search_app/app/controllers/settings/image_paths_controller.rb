module Settings
  class ImagePathsController < ApplicationController
    include ApplicationHelper

    before_action :set_image_path, only: %i[ show edit update destroy create ]

    # GET /settings/image_paths
    def index
      @image_paths = ImagePath.order(updated_at: :desc)
      @pagy, @image_paths = pagy(@image_paths)
    end

    # GET /settings/image_paths/1
    def show
    end

    # GET /settings/image_paths/new
    def new
      @image_path = ImagePath.new
    end

    # GET /settings/image_paths/1/edit
    def edit
    end

    # POST /settings/image_paths
    def create
      respond_to do |format|
          flash[:alert] = feature_unavailable_alert
        format.html { redirect_to [:settings, @image_path] }
      end
    end

    # PATCH/PUT /settings/image_paths/1
    def update
      respond_to do |format|
          flash[:alert] = feature_unavailable_alert
        format.html { redirect_to [:settings, @image_path] }
      end
    end

    # DELETE /settings/image_paths/1
    def destroy
      respond_to do |format|
        flash[:alert] = feature_unavailable_alert
        format.html { redirect_to [:settings, @image_path] }
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
end
