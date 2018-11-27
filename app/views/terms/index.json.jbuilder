# frozen_string_literal: true

json.array!(@terms) do |term|
  json.extract! term, :id, :dtstart, :dtend, :name
  json.url term_url(term, format: :json)
end
