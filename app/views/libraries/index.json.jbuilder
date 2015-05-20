json.array!(@libraries) do |library|
  json.extract! library, :id, :name, :slug
  json.url library_url(library, format: :json)
end
