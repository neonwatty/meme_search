class TagNamesController < ApplicationController
  before_action :set_tag_name, only: %i[ show edit update destroy ]

  # GET /tag_names
  def index
    @tag_names = TagName.order(created_at: :desc)
    @pagy, @tag_names = pagy(@tag_names)
  end

  # GET /tag_names/1
  def show
  end

  # GET /tag_names/new
  def new
    @tag_name = TagName.new
  end

  # GET /tag_names/1/edit
  def edit
  end

  # POST /tag_names
  def create
    @tag_name = TagName.new(tag_name_params)

    respond_to do |format|
      if @tag_name.save
        flash[:notice] = "Tag successfully created."
        format.html { redirect_to @tag_name }
      else
        flash[:alert] = @tag_name.errors.full_messages[0]
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tag_names/1
  def update
    respond_to do |format|
      if @tag_name.update(tag_name_params)
        flash[:notice] = "Tag was successfully updated."
        format.html { redirect_to @tag_name }
      else
        flash[:alert] = @tag_name.errors.full_messages[0]
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tag_names/1
  def destroy
    @tag_name.destroy!

    respond_to do |format|
      flash[:notice] = "Tag was successfully destroyed."
      format.html { redirect_to tag_names_path, status: :see_other }
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
