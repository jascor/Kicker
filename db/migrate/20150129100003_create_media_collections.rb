class CreateMediaCollections < ActiveRecord::Migration
  def change
    create_table :media_collections do |t|
      t.string :title
      t.string :raw_creator_name
      t.string :creator_name
      t.text :description
      t.timestamps null: false
    end
  end
end
