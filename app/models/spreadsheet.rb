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
    if location =~ %r{/}
      lib, loc = location.split('/', 2).map(&:strip)
      Library.find(lib).locations.find(loc)
    else
      Location.find(location)
    end
  rescue ActiveRecord::RecordNotFound
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
