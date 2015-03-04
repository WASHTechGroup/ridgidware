json.array!(@holds) do |hold|
  json.extract! hold, :id
  json.url hold_url(hold, format: :json)
end
