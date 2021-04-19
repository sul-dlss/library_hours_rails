# frozen_string_literal: true

require 'csv'
class LegacySpreadsheetParser
  attr_reader :io

  def initialize(io)
    @io = if io.is_a? IO
            io
          else
            StringIO.new(io)
          end
  end

  def hours
    return to_enum(:hours) unless block_given?

    locations.each do |location|
      next if location.blank?

      data.each do |row|
        cal = parse_hours(location, row)
        yield cal
      end
    end
  end

  def process!
    hours.each do |cal|
      unless cal.valid?
        Rails.logger.info "Bad hours found for #{cal.inspect}: #{cal.errors.messages}"
        next
      end

      cal.location.calendars.in_range(cal.dtstart..cal.dtstart.end_of_day).delete_all

      cal.save
    end
  end

  def self.generate(libraries, date_range = nil)
    locations = Array(libraries).map(&:locations).flatten.select(&:keeps_hours)
    date_range ||= Time.zone.now.to_date..(Time.zone.now + 1.year).to_date
    CSV.generate do |csv|
      csv << ['library hours']
      csv << ['', '', '', ''] + locations.map { |l| ["#{l.library.slug} / #{l.slug}", ''] }.flatten
      csv << %w[Date Day Type Notes] + locations.map { %w[Open Close] }.flatten

      date_range.each do |d|
        c = Calendar.for_date(d).first || Calendar.new

        row = [d, d.strftime('%A'), c.summary, c.description]
        location_hours = locations.map do |l|
          c = l.hours(date_range)[d].first
          if c.nil? || c.is_a?(MissingCalendar)
            [nil, nil]
          elsif c.closed?
            ['closed', nil]
          else
            [c.dtstart.localtime.strftime('%I:%M %p'), c.dtend.localtime.strftime('%I:%M %p')]
          end
        end

        csv << row + location_hours.flatten
      end
    end
  end

  def date_ranges
    @date_ranges ||= begin
      missing = range.to_a - dates

      return [range] if missing.none?

      last = range.begin
      ranges = []
      missing.each do |d|
        tmp = last
        last = d + 1

        next if missing.include?(d - 1)

        ranges << (tmp..(d - 1))
      end

      ranges << (last..range.end) if last < range.end

      ranges
    end
  end

  def range
    @range ||= dates.min..dates.max
  end

  def dates
    @dates ||= data.map(&:first).reject(&:blank?).map do |x|
      Date.parse(x)
               rescue StandardError
                 nil
    end .compact
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

  def parse_hours(location, row)
    date = row[0]
    type = row[2]
    note = row[3]

    i = location_index(location)
    open = row[i].try(:strip)
    close = row[i + 1].try(:strip)

    cal = Calendar.new do |c|
      c.location = fetch_location(location)
      c.summary = type
      c.description = note

      if open == 'closed'
        c.closed!(date)
      else
        c.dtstart_unparsed = "#{date} #{open}"
        c.dtend_unparsed = "#{date} #{close}"
      end
    end

    cal
  end

  def fetch_location(location)
    @locations_cache = {}

    @locations_cache[location] ||= if %r{/}.match?(location)
                                     lib, loc = location.split('/', 2).map(&:strip)
                                     Library.find(lib).locations.find(loc)
                                   else
                                     Location.find(location)
                                   end
  rescue ActiveRecord::RecordNotFound
    nil
  end

  def data
    csv[3..csv.length]
  end

  def bad_data
    return to_enum(:bad_data) unless block_given?

    hours.each do |cal|
      yield cal unless cal.valid?
    end
  end

  def csv
    @csv ||= CSV.parse(io.read.gsub(/\s*$/, ''))
  end
end
