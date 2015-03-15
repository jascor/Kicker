json.results do
  json.array! @results do |r|
    json.id r.id
    json.title r.headline
    json.additional_info do
      json.writer_name r.writer_name
    end
  end
end

json.meta do
  json.total_results @results.count
end