# frozen_string_literal: true

class Location < ApplicationRecord
  belongs_to :library
  has_one :node_mapping, as: :mapped
  delegate :node_id, to: :node_mapping, allow_nil: true
  has_many :calendars
  has_many :term_hours
  accepts_nested_attributes_for :node_mapping, reject_if: :all_blank

  scope :with_hours, -> { where(keeps_hours: true) }
  scope :without_hours, -> { where(keeps_hours: false) }

  validates :name, presence: true

  extend FriendlyId
  friendly_id :name, use: %i[slugged finders scoped history], scope: :library

  def default_hours(range)
    term_hours.for_range(range)
  end

  def hours(range)
    @hours ||= {}
    @hours[range] ||= Hours.new(self, range)
  end

  def business_days(range_start, business_days = 1)
    business_days_counter = 0

    (range_start.to_date..(range_start + 1.year).to_date).step(7).each do |r|
      open_days = hours(r..(r + 6))

      open_days.each do |d|
        business_days_counter += 1 if d.any?(&:open?)
        return d.first if business_days_counter >= business_days
      end
    end

    nil
  end

  def node_id?
    node_mapping&.node_id?
  end
end
