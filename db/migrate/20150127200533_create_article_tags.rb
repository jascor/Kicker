class CreateArticleTags < ActiveRecord::Migration
  def change
    create_table :article_tags do |t|
      t.references :tag
      t.references :article
      t.timestamps null: false
    end
  end
end
