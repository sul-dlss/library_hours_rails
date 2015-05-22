class LocationsController < ApplicationController
  load_and_authorize_resource

  before_action :set_range, only: [:show]
  # GET /locations
  # GET /locations.json
  def index
    @locations = Location.all
  end

  # GET /locations/1
  # GET /locations/1.json
  def show
  end

  def hours
    @range = Time.parse(params[:from]).to_date..Time.parse(params[:to]).to_date if params[:from] && params[:to]
    @range ||= Time.parse(params[:when]).to_date..Time.parse(params[:when]).to_date if params[:when]
    @range ||= Calendar.week(params[:week]) if params[:week]
    @range ||= Time.now.to_date..Time.now.to_date
    @hours = @location.calendars.in_range(@range)
  end

  def hours_v1
    @when = params[:when] == 'today' ? Time.now : Time.parse(params[:when])
    @hours = @location.calendars.for_date(@when)
  end

  # GET /locations/new
  def new
    @location = Location.new
  end

  # GET /locations/1/edit
  def edit
  end

  # POST /locations
  # POST /locations.json
  def create
    @location = Location.new(location_params)

    respond_to do |format|
      if @location.save
        format.html { redirect_to @location, notice: 'Location was successfully created.' }
        format.json { render :show, status: :created, location: @location }
      else
        format.html { render :new }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /locations/1
  # PATCH/PUT /locations/1.json
  def update
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to @location, notice: 'Location was successfully updated.' }
        format.json { render :show, status: :ok, location: @location }
      else
        format.html { render :edit }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location.destroy
    respond_to do |format|
      format.html { redirect_to locations_url, notice: 'Location was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def location_params
    params.require(:location).permit(:name, :slug, :library_id)
  end
end
