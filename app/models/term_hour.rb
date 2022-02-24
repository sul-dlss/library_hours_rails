# frozen_string_literal: true

class TermHour < ApplicationRecord
  belongs_to :term
  belongs_to :location
  validates :term, :location, presence: true

  store :data, accessors: %i[sunday monday tuesday wednesday thursday friday saturday], coder: JSON

  delegate :year, to: :term
  delegate :library, to: :location

  validates :sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, calendar_range: true

  def sunday=(val)
    super(val.strip)
  end

  def monday=(val)
    super(val.strip)
  end

  def tuesday=(val)
    super(val.strip)
  end

  def wednesday=(val)
    super(val.strip)
  end

  def thursday=(val)
    super(val.strip)
  end

  def friday=(val)
    super(val.strip)
  end

  def saturday=(val)
    super(val.strip)
  end
end
