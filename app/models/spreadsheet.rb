class Spreadsheet < ActiveRecord::Base
  attachment :attachment

  validates :attachment, presence: true

  def import
    parser.process!
  end

  def locations
    Hash[*parser.locations.map { |l| [l, find_location(l)] }.flatten]
  end

  def find_location(location)
    if location =~ '/'
      lib, loc = location.split('/', 2).map(&:strip)
      c.location = Library.find(lib).locations.find(loc)
    else
      c.location = Location.find(location)
    end
  rescue
    nil
  end

  def continuous?
    dates.length == 1
  end

  def empty_cells
    parser.empty_cells
  end

  def dates
    parser.date_ranges
  end

  def parser
    @parser ||= LegacySpreadsheetParser.new(attachment)
  end
end
