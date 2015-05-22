class Spreadsheet < ActiveRecord::Base
  attachment :attachment

  validates :attachment, presence: true

  def import
    parser.process!
  end

  def locations
    Hash[*parser.locations.map { |l| [l, (Location.find(l) if Location.exists?(l))] }.flatten]
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
