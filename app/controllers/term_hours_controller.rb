# frozen_string_literal: true

class TermHoursController < ApplicationController
  load_and_authorize_resource :library
  load_and_authorize_resource :location, through: :library, except: [:index]
  load_and_authorize_resource through: :location, except: [:index]

  # GET /term_hours
  # GET /term_hours.json
  def index
    authorize! :manage, @library
    @terms = Term.current_and_upcoming(1.year).quarters_and_intersessions.group_by(&:year)
  end

  # GET /libraries/:library_id/locations/:location_id/term_hours/1
  def show; end

  # GET /libraries/:library_id/locations/:location_id/term_hours/new?term=<term_id>
  def new
    @term_hour.term = Term.find(params.require(:term_id))
  end

  # GET /term_hours/1/edit
  def edit; end

  # POST /term_hours
  # POST /term_hours.json
  def create
    @term_hour.term = Term.find(params.require(:term_id))
    if TermHour.exists?(term: @term_hour.term, location: @term_hour.location)
      @term_hour = TermHour.find_by(term: @term_hour.term, location: @term_hour.location)
      return update
    end

    respond_to do |format|
      if @term_hour.save
        format.html do
          redirect_to library_location_term_hour_path(@library, @location, @term_hour, day_of_week: params[:day_of_week]), notice: 'Term hour was successfully created.'
        end
        format.json { head :no_content }
      else
        format.html { render :new }
        format.json { render json: @term_hour.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /term_hours/1
  # PATCH/PUT /term_hours/1.json
  def update
    respond_to do |format|
      if @term_hour.update(term_hour_params)
        format.html do
          redirect_to library_location_term_hour_path(@library, @location, @term_hour, day_of_week: params[:day_of_week]), notice: 'Term hour was successfully updated.'
        end
        format.json { head :no_content }
      else
        format.html { render :edit }
        format.json { render json: @term_hour.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /term_hours/1
  # DELETE /term_hours/1.json
  def destroy
    @term_hour.destroy
    respond_to do |format|
      format.html { redirect_to library_location_term_hours_path(@library, @location), notice: 'Term hour was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def term_hour_params
    params.expect(term_hour: %i[term_id sunday monday tuesday wednesday thursday friday saturday])
  end
end
