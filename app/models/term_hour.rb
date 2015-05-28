class TermHour < ActiveRecord::Base
  belongs_to :term
  belongs_to :location
  validates :term, :location, presence: true

  serialize :data

  delegate :year, to: :term
  delegate :library, to: :location
end
