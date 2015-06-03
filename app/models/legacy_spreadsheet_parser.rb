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

  def self.generate(libraries, date_range = nil)
    locations = Array(libraries).map(&:locations).flatten.reject { |x| x.calendars.none? }
    date_range ||= Time.zone.now.to_date..(Time.zone.now + 1.year).to_date
    CSV.generate do |csv|
      csv << ['library hours']
      csv << ['', '', '', ''] + locations.map { |l| ["#{l.library.slug} / #{l.slug}", '']}.flatten
      csv << ['Date', 'Day', 'Type', 'Notes'] + locations.map { ['Open', 'Close'] }.flatten

      date_range.each do |d|
        c = Calendar.for_date(d).first
        csv << [d, d.strftime('%A'), c.summary, c.description] + locations.map { |l| c = l.calendars.for_date(d).first; c ? [c.dtstart.localtime.strftime('%I:%M %p'), c.dtend.localtime.strftime('%I:%M %p')] : ['', ''] }.flatten
      end
    end
  end

  # rubocop:disable Metrics/MethodLength
  def date_ranges
    @date_ranges ||= begin
      missing = range.to_a - dates

      return [range] if missing.none?

      last = range.begin
      ranges = []
      missing.each_with_object(ranges) do |d|
        tmp = last
        last = d + 1

        next if missing.include?(d - 1)

        ranges << (tmp..(d - 1))
      end

      ranges << (last..range.end) if last < range.end

      ranges
    end
  end
  # rubocop:enable Metrics/MethodLength

  def range
    @range ||= dates.min..dates.max
  end

  def dates
    @dates ||= data.map(&:first).map { |x| Date.parse(x) }
  end

  def locations
    locations_row.reject(&:blank?)
  end

  def locations_row
    csv[1]
  end

  def headers_row
    csv[2]
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
      if location =~ %r{/}
        lib, loc = location.split('/', 2).map(&:strip)
        c.location = Library.find(lib).locations.find(loc)
      else
        c.location = Location.find(location)
      end
      if open == 'closed'
        c.dtstart = Time.zone.parse("#{date} #{open}").midnight
        c.dtend = c.dtstart
        c.closed = true
      else
        c.dtstart = Time.zone.parse("#{date} #{open}")

        # whenever we say 11:59PM, we mean the very end of the day
        if close =~ /^11:59\s*(PM|pm)$/
          c.dtend = Time.zone.parse(date).end_of_day
        else
          c.dtend = Time.zone.parse("#{date} #{close}")
        end

        if c.dtend < c.dtstart
          next_date = Date.parse(date) + 1.day
          c.dtend = Time.zone.parse("#{next_date} #{close}")
        end
      end
      c.summary = type
      c.description = note
    end
  end
  # rubocop:enable Metrics/MethodLength

  def data
    csv[3..csv.length]
  end

  def empty_cells
    data.each_with_index.map do |row, row_idx|
      row.each_with_index.map do |cell, col_idx|
        next unless (locations_row[col_idx] || locations_row[col_idx - 1]).present?
        next if cell.blank? && (data[row_idx][col_idx - 1]) == 'closed'
        next if cell == 'closed' || (Time.zone.parse(cell) rescue nil)

        [data[row_idx][0], locations_row[col_idx] || locations_row[col_idx - 1], headers_row[col_idx], cell]
      end.compact
    end.compact.flatten(1)
  end

  def csv
    @csv ||= CSV.parse(io.read)
  end
end
