class PartsController < ApplicationController
  before_action :set_part, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction

  # GET /parts
  # GET /parts.json
  def index
    @parts = Part.joins(:inventory).search(params[:search]).order(sort_column + " " + sort_direction)
  end

  # GET /parts/1
  # GET /parts/1.json
  def show
  end

  # GET /parts/new
  def new
    @part = Part.new
    @part.inventory= Inventory.new
  end

  # GET /parts/1/edit
  def edit
  end

  # GET /catalog
  def catalog
    @parts = Part.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 10, :page => params[:id])
    respond_to do |format|
      format.html { render :catalog, :layout => nil }
    end
  end

  # POST /parts
  # POST /parts.json
  def create
    @part = Part.new(part_params)

    respond_to do |format|
      if @part.save
        format.html { redirect_to @part, notice: 'Part was successfully created.' }
        format.json { render :show, status: :created, location: @part }
      else
        format.html { render :new }
        format.json { render json: @part.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /parts/1
  # PATCH/PUT /parts/1.json
  def update
    respond_to do |format|
      if @part.update(part_params)
        format.html { redirect_to @part, notice: 'Part was successfully updated.' }
        format.json { render :show, status: :ok, location: @part }
      else
        format.html { render :edit }
        format.json { render json: @part.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /parts/1
  # DELETE /parts/1.json
  def destroy
    @part.destroy
    respond_to do |format|
      format.html { redirect_to parts_url, notice: 'Part was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_part
      @part = Part.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def part_params
      params[:part]
    end

    def sort_column 
      %w[part_number description price available].include?(params[:sort]) ? params[:sort] : "part_number"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc" 
    end
end
