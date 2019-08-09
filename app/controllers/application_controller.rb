# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user
  check_authorization

  def current_user
    @current_user ||= if Rails.env.development?
                        User.from_env(request.env.merge(ENV))
                      else
                        User.from_env(request.env)
                      end
  end

  def set_range(default: nil)
    redirect_to week: Time.zone.parse(params[:date]).strftime('%GW%V'), date: nil if params[:date]

    @range = Time.zone.parse(params[:from]).to_date..Time.zone.parse(params[:to]).to_date if params[:from] && params[:to]
    if params[:from] && params[:business_days] && instance_variable_defined?(:@location)
      @range ||= begin
        range_start = Time.zone.parse(params[:from])
        range_end = @location.business_days(range_start, params[:business_days].to_i).date
        range_start.to_date..range_end if range_end
      end
    end
    @range ||= Time.zone.parse(params[:from]).to_date..Time.zone.parse(params[:from]).to_date if params[:from]
    @range ||= Time.zone.parse(params[:when]).to_date..Time.zone.parse(params[:when]).to_date if params[:when]
    @range ||= Calendar.week(params[:week]) if params[:week]

    default ||= Calendar.week(Time.zone.now.strftime('%GW%V'))
    @range ||= default

    @range.tap { |range| raise ActionController::BadRequest, 'Requested range is too big' if range.first + 18.months < range.last }
  end
end
