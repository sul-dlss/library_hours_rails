# frozen_string_literal: true

class LocationsController < ApplicationController
  load_and_authorize_resource :library
  before_action :find_location_by_legacy_slug, only: :hours_v1
  load_and_authorize_resource through: :library

  before_action :set_range, only: [:show]

  before_action only: %i[open hours] do
    set_range(default: Time.zone.now.to_date..Time.zone.now.end_of_day.to_date)
  end

  # GET /locations
  # GET /locations.json
  def index
    redirect_to library_path(@library)
  end

  # GET /locations/1
  # GET /locations/1.json
  def show; end

  def open
    @hours = @location.hours(@range)
  end

  def hours
    @hours = @location.hours(@range)
  end

  def hours_v1
    @when = (params[:when] == 'today' ? Time.zone.now : Time.zone.parse(params[:when])).beginning_of_day
    @hours = @location.hours(@when.to_date..@when.end_of_day.to_date)

    request.format = :json

    respond_to do |format|
      format.json
    end
  end

  # GET /locations/new
  def new; end

  # GET /locations/1/edit
  def edit; end

  # POST /locations
  # POST /locations.json
  def create
    respond_to do |format|
      if @location.save
        format.html { redirect_to [@location.library, @location], notice: 'Location was successfully created.' }
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
        format.html { redirect_to [@location.library, @location], notice: 'Location was successfully updated.' }
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
      format.html { redirect_to library_url(@location.library), notice: 'Location was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def location_params
    params.require(:location).permit(:name, :slug, :library_id, :keeps_hours)
  end

  def find_location_by_legacy_slug
    @location ||= @library.locations.friendly.find(params[:id])
  end
end
