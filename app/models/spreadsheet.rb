class Spreadsheet < ActiveRecord::Base
  attachment :attachment

  validates :attachment, presence: true

  delegate :bad_data, to: :parser

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

  def dates
    parser.date_ranges
  end

  def parser
    @parser ||= LegacySpreadsheetParser.new(attachment)
  end
end
