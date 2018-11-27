# frozen_string_literal: true

class MissingCalendar < Calendar
  def closed?
    true
  end
end
