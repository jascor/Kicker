json.results do
  json.array! @results do |r|
    json.id r.id
    json.title r.name
  end
end

json.meta do
  json.total_results @results.count
end