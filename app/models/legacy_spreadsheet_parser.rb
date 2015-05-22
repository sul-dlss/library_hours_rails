class LegacySpreadsheetParser
  attr_reader :io

  def initialize(io)
    @io = io
  end

  def process!
    locations.each do |location|
      next if location.blank?

      data.each do |row|
        next unless Location.exists?(location)
        cal = hours(location, row)

        next unless cal

        cal.location.calendars.in_range(cal.dtstart..cal.dtstart.end_of_day).delete_all

        cal.save
      end
    end
  end

  def locations
    locations_row.reject(&:blank?)
  end

  def locations_row
    csv[1]
  end

  def location_index(location)
    locations_row.index(location)
  end

  # rubocop:disable Metrics/MethodLength
  def hours(location, row)
    date = row[0]
    type = row[2]
    note = row[3]

    i = location_index(location)
    open = row[i]
    close = row[i + 1]

    Calendar.new do |c|
      c.location = Location.find(location)
      if open == 'closed'
        c.dtstart = Time.parse("#{date} #{open}").midnight
        c.dtend = c.dtstart
        c.closed = true
      else
        c.dtstart = Time.parse("#{date} #{open}")

        # whenever we say 11:59PM, we mean the very end of the day
        if close =~ /^11:59\s*(PM|pm)$/
          c.dtend = Time.parse(date).end_of_day
        else
          c.dtend = Time.parse("#{date} #{close}")
        end

        c.dtend = c.dtend + 1.day if c.dtend < c.dtstart
      end
      c.summary = type
      c.description = note
    end
  end
  # rubocop:enable Metrics/MethodLength

  def data
    csv[3..csv.length]
  end

  def csv
    @csv ||= CSV.parse(io.read)
  end
end
