class Term < ActiveRecord::Base
  validates :name, presence: true

  def self.missing_for_location(location)
    blacklisted_term_ids = location.term_hours.pluck(:term_id)
    Term.all.reject { |t| blacklisted_term_ids.include? t.id }
  end

  delegate :year, to: :dtstart
end
