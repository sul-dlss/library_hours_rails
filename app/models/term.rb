class Term < ActiveRecord::Base
  validates :name, presence: true

  default_scope { order(dtstart: 'asc') }

  scope :quarters_and_intersessions, ->() { where(holiday: false) }
  scope :holidays, ->() { where(holiday: true) }

  scope :current_and_upcoming, ->() { where('dtstart >= ?', Time.now.beginning_of_year) }

  def self.missing_for_location(location)
    blacklisted_term_ids = location.term_hours.pluck(:term_id)
    Term.all.reject { |t| blacklisted_term_ids.include? t.id }
  end

  delegate :year, to: :dtstart
end
