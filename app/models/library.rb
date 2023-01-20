# frozen_string_literal: true

class Library < ApplicationRecord
  has_one :node_mapping, as: :mapped, dependent: :destroy
  delegate :node_id, to: :node_mapping, allow_nil: true
  has_many :locations
  accepts_nested_attributes_for :locations, allow_destroy: true
  accepts_nested_attributes_for :node_mapping, reject_if: :all_blank

  validates :name, presence: true

  extend FriendlyId
  friendly_id :slug, use: %i[slugged finders history]

  def sort_key
    return '0' if slug == Settings.pinned_library_slug

    name
  end

  def primary_location
    @primary_location ||= locations.find(&:primary)
  end
end
