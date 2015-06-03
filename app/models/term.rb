class Term < ActiveRecord::Base
  validates :name, presence: true

  before_save do
    self.dtstart &&= dtstart.beginning_of_day
    self.dtend &&= dtend.end_of_day
  end

  default_scope { order(dtstart: 'asc') }

  scope :quarters_and_intersessions, ->() { where(holiday: false) }
  scope :holidays, ->() { where(holiday: true) }

  scope :current_and_upcoming, ->(range) { where('dtstart >= ? AND dtstart <= ?', Time.zone.now.beginning_of_year, (Time.zone.now + range).end_of_year) }
  scope :for_date, (lambda do |dt|
    where('dtstart <= ? AND dtend >= ?', dt.to_time.midnight, dt.to_time.midnight)
  end)

  validate :terms_cannot_overlap, unless: :holiday?

  def self.missing_for_location(location)
    blacklisted_term_ids = location.term_hours.pluck(:term_id)
    Term.all.reject { |t| blacklisted_term_ids.include? t.id }
  end

  delegate :year, to: :dtstart

  def terms_cannot_overlap
    if Term.where(holiday: false).where('? BETWEEN dtstart AND dtend', dtstart).where.not(id: id).any?
      errors.add(:dtstart, "can't overlap with other terms")
    end

    if Term.where(holiday: false).where('? BETWEEN dtstart AND dtend', dtend).where.not(id: id).any?
      errors.add(:dtend, "can't overlap with other terms")
    end
  end

  def self.holiday?(dt)
    Term.holidays.for_date(dt).any?
  end
end
