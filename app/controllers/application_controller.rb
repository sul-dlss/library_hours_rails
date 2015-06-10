class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include Squash::Ruby::ControllerMethods
  enable_squash_client

  helper_method :current_user
  check_authorization

  def current_user
    @current_user ||= if Rails.env.development?
                        User.from_env(request.env.merge(ENV))
                      else
                        User.from_env(request.env)
                      end
  end

  def set_range(default = nil)
    if params[:date]
      redirect_to week: Time.zone.parse(params[:date]).strftime('%GW%V'), date: nil
    end

    @range = Time.zone.parse(params[:from]).to_date..Time.zone.parse(params[:to]).to_date if params[:from] && params[:to]
    @range ||= Time.zone.parse(params[:when]).to_date..Time.zone.parse(params[:when]).to_date if params[:when]
    @range ||= Calendar.week(params[:week]) if params[:week]

    default ||= Calendar.week(Time.zone.now.strftime('%GW%V'))
    @range ||= default
  end
end
