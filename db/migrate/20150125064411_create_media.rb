class CreateMedia < ActiveRecord::Migration
  def change
    create_table :media do |t|
      t.boolean :video
      t.references :user
      t.string :filename
      t.string :title
      t.string :credit
      t.string :mime_type
      t.string :s3_key
      t.string :one_to_one_crop
      t.string :three_to_two_crop
      t.string :four_to_three_crop
      t.string :sixteen_to_nine_crop
      t.integer :image_width
      t.integer :image_height
      t.text :link
      t.text :secure_link
      t.text :caption
      t.timestamps null: false
    end
  end
end
