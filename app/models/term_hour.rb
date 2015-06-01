class TermHour < ActiveRecord::Base
  belongs_to :term
  belongs_to :location
  validates :term, :location, presence: true

  store :data, accessors: [:sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday], coder: JSON

  delegate :year, to: :term
  delegate :library, to: :location

  validates :sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, calendar_range: true
end
