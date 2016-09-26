class Library < ActiveRecord::Base
  has_one :node_mapping, as: :mapped
  delegate :node_id, to: :node_mapping
  has_many :locations
  accepts_nested_attributes_for :locations
  accepts_nested_attributes_for :node_mapping

  validates :name, presence: true

  extend FriendlyId
  friendly_id :slug, use: [:slugged, :finders, :history]
end
