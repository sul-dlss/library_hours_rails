json.type 'libraries'
json.id library.slug

json.attributes do
  json.extract! library, :name
  if library.primary_location
    json.primary_location "#{library.slug}/#{library.primary_location.slug}"

    json.hours do
      json.array!(library.primary_location.hours(@range)) do |hours|
        c = hours.first
        json.day c.dtstart.to_date
        json.weekday c.dtstart.strftime('%A')

        unless c.closed?
          json.opens_at c.dtstart.localtime
          json.closes_at c.dtend.localtime
        end

        json.type c.summary.to_s if c.summary
        json.notes c.description.to_s if c.description
        json.closed c.closed?

        if c.already_open_from_previous_day? || c.still_open_on_next_day?
          json.already_open_from_previous_day c.already_open_from_previous_day?
          json.still_open_on_next_day c.still_open_on_next_day?
        end
      end
    end
  end
end

json.relationships do
  json.locations do

    json.data do
      json.array!(library.locations.with_hours) do |location|
        json.type 'locations'
        json.id "#{library.slug}/#{location.slug}"
      end
    end

    json.links do
      json.related library_locations_url(library)
    end
  end
end

json.links do
  json.self library_url(library)
end
