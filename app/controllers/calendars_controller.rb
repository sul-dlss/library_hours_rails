# frozen_string_literal: true

class CalendarsController < ApplicationController
  load_and_authorize_resource :library
  load_and_authorize_resource :location, through: :library
  load_and_authorize_resource through: :location

  def create
    @calendar.dtstart = Time.zone.parse(params[:day])

    unless Calendar.valid_range? date_params[:time]
      render(status: :bad_request, plain: "#{date_params[:time]} is not a valid time") && return
    end

    @calendar.update_hours(date_params[:time])

    respond_to do |format|
      if @calendar.save
        format.json { head :no_content } # 204 No Content
      else
        format.json { raise }
      end
    end
  end

  def update
    unless Calendar.valid_range? date_params[:time]
      render(status: :bad_request, plain: "#{date_params[:time]} is not a valid time") && return
    end

    @calendar.update_hours(date_params[:time])

    respond_to do |format|
      if @calendar.save
        format.json { head :no_content } # 204 No Content
      else
        format.json { raise }
      end
    end
  end

  private

  def date_params
    params.require(:date).permit(:day, :time)
  end
end
