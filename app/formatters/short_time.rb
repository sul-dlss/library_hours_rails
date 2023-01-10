class ShortTime
  def self.render(dt)
    if dt.min == 0
      I18n.l(dt, format: :hours_only).strip
    else
      I18n.l(dt, format: :very_short).strip
    end
  end
end