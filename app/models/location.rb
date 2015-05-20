class Location < ActiveRecord::Base
  belongs_to :library
  has_one :node_mapping, as: :mapped
  has_many :calendars
  accepts_nested_attributes_for :node_mapping

  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders, :scoped, :history], scope: :library

  def hours(range)
    range.step(1.day).map do |_d|
    end
  end

  def today
    @today ||= calendars.in_range(Time.now..Time.now).first
  end
end
