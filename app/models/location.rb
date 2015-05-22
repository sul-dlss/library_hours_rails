class Location < ActiveRecord::Base
  belongs_to :library
  has_one :node_mapping, as: :mapped
  has_many :calendars
  accepts_nested_attributes_for :node_mapping

  validates :name, presence: true

  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders, :scoped, :history], scope: :library
end
