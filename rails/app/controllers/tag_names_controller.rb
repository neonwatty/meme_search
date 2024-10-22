class TagNamesController < ApplicationController
  before_action :set_tag_name, only: %i[ show edit update destroy ]

  # GET /tag_names or /tag_names.json
  def index
    @tag_names = TagName.all
  end

  # GET /tag_names/1 or /tag_names/1.json
  def show
  end

  # GET /tag_names/new
  def new
    @tag_name = TagName.new
  end

  # GET /tag_names/1/edit
  def edit
  end

  # POST /tag_names or /tag_names.json
  def create
    @tag_name = TagName.new(tag_name_params)

    respond_to do |format|
      if @tag_name.save
        format.html { redirect_to @tag_name, notice: "Tag name was successfully created." }
        format.json { render :show, status: :created, location: @tag_name }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tag_name.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tag_names/1 or /tag_names/1.json
  def update
    respond_to do |format|
      if @tag_name.update(tag_name_params)
        format.html { redirect_to @tag_name, notice: "Tag name was successfully updated." }
        format.json { render :show, status: :ok, location: @tag_name }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tag_name.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tag_names/1 or /tag_names/1.json
  def destroy
    @tag_name.destroy!

    respond_to do |format|
      format.html { redirect_to tag_names_path, status: :see_other, notice: "Tag name was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tag_name
      @tag_name = TagName.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tag_name_params
      params.fetch(:tag_name, {})
    end
end
