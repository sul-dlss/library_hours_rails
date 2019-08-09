# frozen_string_literal: true
json.data do
  json.array!(@libraries) do |library|
    json.partial! library
  end
end

json.included do
  json.array!(@libraries.flat_map(&:locations)) do |location|
    json.partial! location
  end
end
