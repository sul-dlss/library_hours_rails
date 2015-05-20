class NodeMappingsController < ApplicationController
  before_action :set_node_mapping, only: [:show, :edit, :update, :destroy]

  # GET /node_mappings
  # GET /node_mappings.json
  def index
    @node_mappings = NodeMapping.all
  end

  # GET /node_mappings/1
  # GET /node_mappings/1.json
  def show
  end

  # GET /node_mappings/new
  def new
    @node_mapping = NodeMapping.new
  end

  # GET /node_mappings/1/edit
  def edit
  end

  # POST /node_mappings
  # POST /node_mappings.json
  def create
    @node_mapping = NodeMapping.new(node_mapping_params)

    respond_to do |format|
      if @node_mapping.save
        format.html { redirect_to @node_mapping, notice: 'Node mapping was successfully created.' }
        format.json { render :show, status: :created, location: @node_mapping }
      else
        format.html { render :new }
        format.json { render json: @node_mapping.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /node_mappings/1
  # PATCH/PUT /node_mappings/1.json
  def update
    respond_to do |format|
      if @node_mapping.update(node_mapping_params)
        format.html { redirect_to @node_mapping, notice: 'Node mapping was successfully updated.' }
        format.json { render :show, status: :ok, location: @node_mapping }
      else
        format.html { render :edit }
        format.json { render json: @node_mapping.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /node_mappings/1
  # DELETE /node_mappings/1.json
  def destroy
    @node_mapping.destroy
    respond_to do |format|
      format.html { redirect_to node_mappings_url, notice: 'Node mapping was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_node_mapping
    @node_mapping = NodeMapping.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def node_mapping_params
    params.require(:node_mapping).permit(:node_id, :mapped_id, :mapped_type)
  end
end
