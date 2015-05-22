class CalendarsController < ApplicationController
  load_and_authorize_resource :library
  load_and_authorize_resource :location, through: :library
  load_and_authorize_resource through: :location

  def create
    @calendar.dtstart = Time.parse(params[:day])
    @calendar.update_hours(date_params[:time])

    respond_to do |format|
      if @calendar.save
        format.json { head :no_content } # 204 No Content
      else
        format.json { fail }
      end
    end
  end

  def update
    @calendar.update_hours(date_params[:time])

    respond_to do |format|
      if @calendar.save
        format.json { head :no_content } # 204 No Content
      else
        format.json { fail }
      end
    end
  end

  private

  def date_params
    params.require(:date).permit(:day, :time)
  end
end
