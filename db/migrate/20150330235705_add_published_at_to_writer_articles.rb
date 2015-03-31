class AddPublishedAtToWriterArticles < ActiveRecord::Migration
  def change
    add_column :writer_articles, :published_at, :datetime
  end
end
