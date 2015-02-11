class WriterArticle < ActiveRecord::Base
  has_one :article

  belongs_to :writer
end
