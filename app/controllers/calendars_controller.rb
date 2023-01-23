# frozen_string_literal: true

class CalendarsController < ApplicationController
  load_and_authorize_resource :library
  load_and_authorize_resource :location, through: :library
  load_and_authorize_resource through: :location

  def new
    @calendar.dtstart = Time.zone.parse(params[:day])
  end

  def edit
  end

  def show
  end

  # This operates as the show route for the non-persisted calendar entry
  def index
    day = Time.zone.parse(params[:day]).to_date
    @calendar = @location.hours(day..day).default_for_date(day)
    render 'show'
  end

  def create
    @calendar.dtstart = Time.zone.parse(params[:day])

    unless Calendar.valid_range? date_params[:time]
      @calendar.errors.add(:base, :format, message: "#{date_params[:time]} is not a valid time")
      render('edit') && return
    end

    @calendar.update_hours(date_params[:time])

    unless @calendar.save
      render :new
    end
  end

  def update
    unless Calendar.valid_range? date_params[:time]
      render(status: :bad_request, plain: "#{date_params[:time]} is not a valid time") && return
    end

    @calendar.update_hours(date_params[:time])

    unless @calendar.save
      render :edit
    end
  end

  private

  def date_params
    params.require(:date).permit(:day, :time)
  end
end
