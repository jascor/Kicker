class CreateMediaCollectionContents < ActiveRecord::Migration
  def change
    create_table :media_collection_contents do |t|
      t.references :media_collection
      t.references :medium
      t.boolean :override_caption
      t.text :caption
      t.integer :position
      t.timestamps null: false
    end
  end
end
