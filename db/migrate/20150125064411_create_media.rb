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
      t.text :link
      t.text :secure_link
      t.text :caption
      t.timestamps null: false
    end
  end
end
