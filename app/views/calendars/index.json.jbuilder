json.array!(@calendars) do |calendar|
  json.extract! calendar, :id, :dtstart, :dtend, :location, :summary, :description
  json.url calendar_url(calendar, format: :json)
end
