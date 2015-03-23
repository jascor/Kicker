json.results do
  json.array! @results do |r|
    if !r.published || r.private
      next
    end

    json.id r.id
    json.title r.headline
    json.link "/short/a/#{r.id}"
    json.score r._score
    json.additional_info do
      json.published_at r.created_at
      json.pretty_publishing_time DateTime.parse(r.created_at).strftime('%m.%d.%Y')
    end
  end
end

json.meta do
  json.total_results @results.count
end