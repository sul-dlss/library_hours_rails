json.type 'libraries'
json.id library.slug

json.attributes do
  json.extract! library, :name
  json.primary_location "#{library.slug}/#{library.primary_location.slug}" if library.primary_location
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
