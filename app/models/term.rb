class Term < ActiveRecord::Base
  validates :name, presence: true

  scope :current_and_upcoming, ->() { where('dtstart >= ?', Time.now.beginning_of_year) }

  def self.missing_for_location(location)
    blacklisted_term_ids = location.term_hours.pluck(:term_id)
    Term.all.reject { |t| blacklisted_term_ids.include? t.id }
  end

  delegate :year, to: :dtstart
end
