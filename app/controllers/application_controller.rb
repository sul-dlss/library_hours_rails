class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def set_range
    @range = Time.parse(params[:from]).to_date..Time.parse(params[:to]).to_date if params[:from] && params[:to]
    @range ||= Time.parse(params[:when]).to_date..Time.parse(params[:when]).to_date if params[:when]
    @range ||= Calendar.week(params[:week]) if params[:week]
    @range ||= Calendar.week(Time.now.strftime('%YW%V'))
  end
end
