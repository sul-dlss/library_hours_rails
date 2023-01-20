json.type 'locations'
json.id "#{location.library.slug}/#{location.slug}"

json.attributes do
  json.extract! location, :name, :primary
  json.hours do
    json.array!(location.hours(@range)) do |hours|
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
    end
  end
end

json.relationships do
  json.library do
    json.links do
      json.related library_url(location.library)
    end

    json.data do
      json.type 'libraries'
      json.id location.library.slug
    end
  end
end

json.links do
  json.self library_location_url(location.library, location)
end
