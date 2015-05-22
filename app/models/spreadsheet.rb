class Spreadsheet < ActiveRecord::Base
  attachment :attachment

  def import
    LegacySpreadsheetParser.new(attachment).process!
  end
end
