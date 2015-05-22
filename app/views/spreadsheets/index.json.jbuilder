json.array!(@spreadsheets) do |spreadsheet|
  json.extract! spreadsheet, :id, :attachment_id, :attachment_filename, :attachment_content_type, :attachment_size, :status
  json.url spreadsheet_url(spreadsheet, format: :json)
end
