json.array!(@locations) do |location|
  json.extract! location, :id, :name, :slug, :library_id
  json.url location_url(location, format: :json)
end
