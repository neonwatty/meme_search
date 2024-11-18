class ImageTagsController < ApplicationController
  include ApplicationHelper
  before_action :set_image_tag, only: %i[ show edit update destroy ]

  # GET /image_tags or /image_tags.json
  def index
    @image_tags = ImageTag.all
  end

  # GET /image_tags/1 or /image_tags/1.json
  def show
  end

  # GET /image_tags/new
  def new
    @image_tag = ImageTag.new
  end

  # GET /image_tags/1/edit
  def edit
  end

  # POST /image_tags or /image_tags.json
  def create
    respond_to do |format|
        flash[:alert] = feature_unavailable_alert
        format.html { redirect_to @image_core }
    end
  end

  # PATCH/PUT /image_tags/1 or /image_tags/1.json
  def update
    respond_to do |format|
        flash[:alert] = feature_unavailable_alert
        format.html { redirect_to @image_core }
    end
  end

  # DELETE /image_tags/1 or /image_tags/1.json
  def destroy
    respond_to do |format|
        flash[:alert] = feature_unavailable_alert
        format.html { redirect_to @image_core }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image_tag
      @image_tag = ImageTag.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def image_tag_params
      params.fetch(:image_tag, {})
    end
end
