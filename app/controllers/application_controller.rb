# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :current_user?
  check_authorization

  def current_user
    @current_user ||= if Rails.env.development?
                        User.from_env(request.env.merge(ENV))
                      else
                        User.from_env(request.env)
                      end
  end

  def current_user?
    current_user.present?
  end

  def set_range(default: nil)
    redirect_to week: (parse_time_param(:date) + 1.day).strftime('%GW%V'), date: nil if params[:date].present?

    @range = parse_time_param(:from).to_date..parse_time_param(:to).to_date if params[:from] && params[:to]
    if params[:from].presence && params[:business_days].presence && instance_variable_defined?(:@location)
      @range ||= begin
        range_start = parse_time_param(:from)
        range_end = @location.business_days(range_start, params[:business_days].to_i)
        range_start.to_date..range_end.date if range_end
      end
    end
    @range ||= parse_time_param(:from).to_date..parse_time_param(:from).to_date if params[:from]

    @range ||= parse_time_param(:when).to_date..parse_time_param(:when).to_date if params[:when]
    @range ||= Calendar.week(params[:week]) if params[:week]
    @range ||= default
    @range ||= Time.zone.now.beginning_of_week(:sunday).to_date..(Time.zone.now.beginning_of_week(:sunday) + 6.days).to_date

    @range.tap { |range| raise ActionController::BadRequest, 'Requested range is too big' if range.first + 18.months < range.last }
    @range.tap { |range| raise ActionController::BadRequest, 'Requested range is too old' if range.first.before? 48.months.ago }
    @range.tap { |range| raise ActionController::BadRequest, 'Requested range is too new' if range.last.after? 24.months.from_now }
  end

  private

  # Parse a user-supplied date/time parameter, treating unparseable or
  # out-of-range values (e.g. "1250dd2") as a bad request rather than a server error.
  def parse_time_param(key)
    Time.zone.parse(params[key].to_s) || raise(ActionController::BadRequest, "Invalid #{key} parameter")
  rescue ArgumentError
    raise ActionController::BadRequest, "Invalid #{key} parameter"
  end
end
