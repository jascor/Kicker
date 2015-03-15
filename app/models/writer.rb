class Writer < ActiveRecord::Base
  include Elasticsearch::Model

  has_many :writer_articles
end
