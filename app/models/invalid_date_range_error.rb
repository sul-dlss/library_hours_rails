# frozen_string_literal: true

class InvalidDateRangeError < RuntimeError
  def initialize(date)
    @date = date
  end
end
