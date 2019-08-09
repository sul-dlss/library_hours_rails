# frozen_string_literal: true

json.data do
  json.partial! @library
end

json.included do
  json.array!(@library.locations.with_hours) do |location|
    json.partial! location
  end
end
