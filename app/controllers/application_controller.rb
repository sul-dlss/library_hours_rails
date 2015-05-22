class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user
  check_authorization

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

  def current_user
    if Rails.env.development?
      User.from_env(request.env.merge(ENV))
    else
      User.from_request(request)
    end
  end

  def set_range
    @range = Time.parse(params[:from]).to_date..Time.parse(params[:to]).to_date if params[:from] && params[:to]
    @range ||= Time.parse(params[:when]).to_date..Time.parse(params[:when]).to_date if params[:when]
    @range ||= Calendar.week(params[:week]) if params[:week]
    @range ||= Calendar.week(Time.now.strftime('%YW%V'))
  end
end
