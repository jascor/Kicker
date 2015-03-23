class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.references :user
      t.references :article_type
      t.references :section
      t.integer :featured_media_id
      t.integer :score
      t.integer :importance, default: 0
      t.boolean :featured_media_is_collection, default: false
      t.boolean :published, default: false
      t.boolean :private, default: false
      t.boolean :disable_comments, default: false
      t.string :headline
      t.string :subheading
      t.text :summary
      t.text :contents
      t.text :raw_contents
      t.text :raw_sass
      t.text :custom_sass
      t.string :slug
      t.datetime :published_at
      t.timestamps
    end
  end
end
