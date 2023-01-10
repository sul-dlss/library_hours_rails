# frozen_string_literal: true

module ApplicationHelper
  def render_short_time(dt)
    ShortTime.render(dt)
  end

  def render_hours(hours)
    if hours.nil? || hours.is_a?(MissingCalendar)
      content_tag :span, 'n/a'
    elsif hours.closed?
      content_tag :span, 'closed', class: 'closed'
    elsif hours.open_24h?
      content_tag :span, 'open 24h', class: 'open-24h'
    else
      render_open_hours_range(hours)
    end
  end

  def render_open_hours_range(hours)
    start = short_time_tag(hours.dtstart.localtime, itemprop: 'opens')
    ends = short_time_tag(hours.dtend.localtime, itemprop: 'closes')
    "#{start}-#{ends}".html_safe
  end

  def short_time_tag(dt, *args)
    time_tag(dt, *args) do
      render_short_time(dt)
    end
  end
end
