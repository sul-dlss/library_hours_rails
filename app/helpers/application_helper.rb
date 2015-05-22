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
end
