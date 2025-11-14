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
    redirect_to week: (Time.zone.parse(params[:date]) + 1.day).strftime('%GW%V'), date: nil if params[:date].present?

    @range = Time.zone.parse(params[:from]).to_date..Time.zone.parse(params[:to]).to_date if params[:from] && params[:to]
    if params[:from].presence && params[:business_days].presence && instance_variable_defined?(:@location)
      @range ||= begin
        range_start = Time.zone.parse(params[:from])
        range_end = @location.business_days(range_start, params[:business_days].to_i)
        range_start.to_date..range_end.date if range_end
      end
    end
    @range ||= if params[:from] && (from = Time.zone.parse(params[:from]))
                 from.to_date..from.to_date
               end

    @range ||= Time.zone.parse(params[:when]).to_date..Time.zone.parse(params[:when]).to_date if params[:when]
    @range ||= Calendar.week(params[:week]) if params[:week]
    @range ||= default
    @range ||= Time.zone.now.beginning_of_week(:sunday).to_date..(Time.zone.now.beginning_of_week(:sunday) + 6.days).to_date

    @range.tap { |range| raise ActionController::BadRequest, 'Requested range is too big' if range.first + 18.months < range.last }
    @range.tap { |range| raise ActionController::BadRequest, 'Requested range is too old' if range.first.before? 48.months.ago }
    @range.tap { |range| raise ActionController::BadRequest, 'Requested range is too new' if range.last.after? 24.months.from_now }
  end
end
