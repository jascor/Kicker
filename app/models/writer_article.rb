class WriterArticle < ActiveRecord::Base
  belongs_to :article

  belongs_to :writer

  def cache_key
    "#{self.class.name}/#{id}"
  end
end