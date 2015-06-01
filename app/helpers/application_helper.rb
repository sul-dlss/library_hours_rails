module ApplicationHelper
  def render_short_time(dt)
    if dt.min == 0
      l(dt, format: :hours_only).strip
    else
      l(dt, format: :very_short).strip
    end
  end

  def render_short_date(dt)
    l(dt, format: :very_short)
  end

  def render_hours(hours)
    case
    when hours.closed?
      content_tag :span, 'closed', class: 'closed'
    when hours.open_24h?
      content_tag :span, 'open 24h', class: 'open-24h'
    when hours.nil?, hours.is_a?(MissingCalendar)
      content_tag :span, 'n/a'
    else
      render_hour_range(hours)
    end
  end

  def render_hour_range(hours)
    start = time_tag(hours.dtstart.localtime, itemprop: 'opens')
    ends = time_tag(hours.dtend.localtime, itemprop: 'closes')
    "#{start}-#{ends}".html_safe
  end

  def time_tag(dt, attr = {})
    content_tag :time, render_short_time(dt), attr.merge(datetime: dt)
  end

  def terms_by_year
    Term.current_and_upcoming.group_by(&:year)
  end
end
