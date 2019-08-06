# frozen_string_literal: true

json.data do
  json.partial! @location
end

json.included do
  json.partial! @location.library
end
