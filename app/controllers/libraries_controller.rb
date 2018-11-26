# frozen_string_literal: true

class LibrariesController < ApplicationController
  load_and_authorize_resource

  before_action :set_range, only: %i[show index]

  # GET /libraries
  # GET /libraries.json
  # GET /libraries.drupal_xml
  def index
    @libraries = @libraries.select { |x| x.locations.any?(&:keeps_hours) }.sort_by(&:sort_key)
    respond_to do |format|
      format.html
      format.json
      format.drupal_xml
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

  def hours_drupal
    month = Time.zone.parse(params[:month])

    # when the month is in the past (and the current week is wholely in the current month), use the following year
    month += 1.year if month < Time.zone.now.beginning_of_week(:sunday).beginning_of_month

    # when it is January, if we request December's hours and the current week starts in December, use the previous year
    if params[:month] == 'december' && Time.zone.now.beginning_of_week(:sunday) < Time.zone.now.beginning_of_year
      month -= 1.year
    end

    @range = month.to_date..month.end_of_month.to_date

    respond_to do |format|
      format.xml
    end
  end

  # GET /libraries/new
  def new; end

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
    params.require(:library).permit(:name, :slug, node_mapping_attributes: [:node_id], locations_attributes: locations_params)
  end

  def locations_params
    [:id, :name, :slug, :keeps_hours, node_mapping_attributes: [:node_id]]
  end
end
