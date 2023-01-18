# frozen_string_literal: true

class LibrariesController < ApplicationController
  load_and_authorize_resource

  before_action :set_range, only: %i[show index]

  # GET /libraries
  # GET /libraries.json
  def index
    @libraries = @libraries.select { |x| x.locations.any?(&:keeps_hours) }.sort_by(&:sort_key)
    respond_to do |format|
      format.html do
        @libraries = @libraries.select(&:public) unless current_user&.site_admin? || current_user&.superadmin?
      end

      format.json
      format.csv { render plain: LegacySpreadsheetParser.generate(@libraries.select { |x| params[:ids].blank? || params[:ids].include?(x.id.to_s) }, @range) }
    end
  end

  # GET /libraries/1
  # GET /libraries/1.json
  def show
    respond_to do |format|
      format.html
      format.json
    end
  end

  def spreadsheet; end

  # GET /libraries/new
  def new
    @library.build_node_mapping
  end

  # GET /libraries/1/edit
  def edit; end

  # POST /libraries
  # POST /libraries.json
  def create
    respond_to do |format|
      if @library.save
        format.html { redirect_to @library, notice: 'Library was successfully created.' }
        format.json { render :show, status: :created, location: @library }
      else
        format.html { render :new }
        format.json { render json: @library.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /libraries/1
  # PATCH/PUT /libraries/1.json
  def update
    respond_to do |format|
      if @library.update(library_params)
        format.html { redirect_to @library, notice: 'Library was successfully updated.' }
        format.json { render :show, status: :ok, location: @library }
      else
        format.html { render :edit }
        format.json { render json: @library.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /libraries/1
  # DELETE /libraries/1.json
  def destroy
    @library.destroy
    respond_to do |format|
      format.html { redirect_to libraries_url, notice: 'Library was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def library_params
    params.require(:library).permit(:name, :slug, :public, node_mapping_attributes: [:id, :node_id], locations_attributes: locations_params)
  end

  def locations_params
    [:id, :name, :slug, :keeps_hours, :primary, :_destroy, node_mapping_attributes: [:id, :node_id]]
  end
end
