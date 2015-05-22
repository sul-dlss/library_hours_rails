class Spreadsheet < ActiveRecord::Base
  attachment :attachment

  validates :attachment, presence: true

  def import
    LegacySpreadsheetParser.new(attachment).process!
  end
end
