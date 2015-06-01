class Hours
  include Enumerable

  attr_reader :location, :range

  def initialize(location, range)
    @location = location
    @range = range
  end

  def calendars
    @calendars ||= location.calendars.in_range(range).group_by(&:date)
  end

  def defaults
    @defaults ||= location.term_hours
  end

  def [](index)
    Array.wrap(calendars[index.to_date] || default_for_date(index.to_date)).compact
  end

  def each
    range.each do |d|
      yield self[d]
    end
  end

  def slice(index_or_range)
    return to_enum(:slice, index_or_range) unless block_given?
    case index_or_range
    when Date
      yield self[index_or_range]
    when Range
      range.each do |d|
        yield self[d]
      end
    end
  end

  def default_for_date(date)
    term_hours = defaults.detect { |x| x.term.dtstart <= date && x.term.dtend >= date }

    r = case
        when date.sunday?
          term_hours.sunday
        when date.monday?
          term_hours.monday
        when date.tuesday?
          term_hours.tuesday
        when date.wednesday?
          term_hours.wednesday
        when date.thursday?
          term_hours.thursday
        when date.friday?
          term_hours.friday
        when date.saturday?
          term_hours.saturday
        end if term_hours

    return MissingCalendar.new(dtstart: date, dtend: date) unless r && r.present?

    Calendar.new.tap do |c|
      c.update_hours(r, date)
    end
  end
end