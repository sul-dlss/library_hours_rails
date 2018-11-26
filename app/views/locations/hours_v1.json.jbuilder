# frozen_string_literal: true

json.array! @hours do |hours|
  c = hours.first

  json.id c.id
  json.day c.dtstart.to_date
  json.weekday c.dtstart.strftime('%A')
  json.opens_at c.dtstart.localtime
  json.closes_at c.dtend.localtime
  json.type c.summary.to_s
  json.notes c.description.to_s
  json.location_slug c.location.slug
  json.location_id c.location_id
  json.closed c.closed?
end
