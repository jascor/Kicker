if Rails.env.production?
  Elasticsearch::Model.client = Elasticsearch::Client.new host: ENV['ELASTICSEARCH_HOST']
else
  Elasticsearch::Model.client = Elasticsearch::Client.new host: '127.0.0.1:9200'
end