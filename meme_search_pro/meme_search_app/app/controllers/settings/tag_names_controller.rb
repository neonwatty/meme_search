module Settings
  class TagNamesController < ApplicationController
    include ApplicationHelper

    before_action :set_tag_name, only: %i[ show edit update destroy create ]

    # GET /settings/tag_names
    def index
      @tag_names = TagName.order(updated_at: :desc)
      @pagy, @tag_names = pagy(@tag_names)
    end

    # GET /settings/tag_names/1
    def show
    end

    # GET /settings/tag_names/new
    def new
      @tag_name = TagName.new
    end

    # GET /settings/tag_names/1/edit
    def edit
    end

    # POST /settings/tag_names
    def create
      respond_to do |format|
          flash[:alert] = feature_unavailable_alert
        format.html { redirect_to [:settings, @tag_name] }
      end
    end

    # PATCH/PUT /settings/tag_names/1
    def update
      respond_to do |format|
          flash[:alert] = feature_unavailable_alert
        format.html { redirect_to [:settings, @tag_name] }
      end
    end

    # DELETE /settings/tag_names/1
    def destroy
      respond_to do |format|
          flash[:alert] = feature_unavailable_alert
        format.html { redirect_to [:settings, @tag_name] }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_tag_name
        @tag_name = TagName.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def tag_name_params
        params.require(:tag_name).permit(:name, :color)
      end
  end
end
