# frozen_string_literal: true

class Spreadsheet < ApplicationRecord
  has_one_attached :attachment

  validate :attachment_validation

  delegate :bad_data, to: :parser

  def import
    parser.process!
  end

  def locations
    Hash[*parser.locations.map { |l| [l, find_location(l)] }.flatten]
  end

  def find_location(location)
    if %r{/}.match?(location)
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
    @parser ||= LegacySpreadsheetParser.new(attachment.download)
  end

  private

  def attachment_validation
    errors.add(:attachment, 'Missing attachment') unless attachment.attached?
  end
end
