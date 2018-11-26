# frozen_string_literal: true

json.array!(@term_hours) do |term_hour|
  json.extract! term_hour, :id, :term_id, :location_id, :data
  json.url term_hour_url(term_hour, format: :json)
end
