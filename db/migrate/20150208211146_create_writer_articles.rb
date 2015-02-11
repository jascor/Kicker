class CreateWriterArticles < ActiveRecord::Migration
  def change
    create_table :writer_articles do |t|
      t.references :article
      t.references :writer
      t.timestamps null: false
    end
  end
end
