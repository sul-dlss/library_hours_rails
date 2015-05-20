json.array!(@node_mappings) do |node_mapping|
  json.extract! node_mapping, :id, :node_id, :mapped_id, :mapped_type
  json.url node_mapping_url(node_mapping, format: :json)
end
