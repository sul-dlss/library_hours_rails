# frozen_string_literal: true

class Library < ApplicationRecord
  has_many :locations
  accepts_nested_attributes_for :locations, allow_destroy: true

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
