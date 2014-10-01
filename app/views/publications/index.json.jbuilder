json.array!(@publications) do |publication|
  json.extract! publication, :id, :title, :venue, :summary, :year
  json.url publication_url(publication, format: :json)
end
