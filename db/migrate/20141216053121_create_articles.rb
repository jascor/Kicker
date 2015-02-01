class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.integer :user_id
      t.integer :featured_media_id
      t.integer :article_type_id
      t.integer :section_id
      t.integer :subsection_id
      t.boolean :published, default: false
      t.boolean :private, default: true
      t.boolean :disable_comments, default: false
      t.string :writer_name
      t.string :raw_writer_name
      t.string :headline
      t.string :subheading
      t.text :summary
      t.text :contents
      t.text :raw_contents
      t.string :slug
      t.datetime :published_at
      t.timestamps
    end
  end
end
