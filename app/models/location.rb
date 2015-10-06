class Location < ActiveRecord::Base
  belongs_to :library
  has_one :node_mapping, as: :mapped
  has_many :calendars
  has_many :term_hours
  accepts_nested_attributes_for :node_mapping

  scope :with_hours, ->() { where(keeps_hours: true) }
  scope :without_hours, ->() { where(keeps_hours: false) }

  validates :name, presence: true

  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders, :scoped, :history], scope: :library

  def default_hours(range)
    term_hours.for_range(range)
  end

  def hours(range)
    @hours ||= {}
    @hours[range] ||= Hours.new(self, range)
  end

  def next_open_hours(range_start)
    day = ((range_start + 1.day).to_date..(range_start + 1.year).to_date).step(7).each do |r|
      open_day = hours(r..(r + 7)).detect { |h| h.any?(&:open?) }
      break open_day if open_day
    end

    day.first
  end
end
