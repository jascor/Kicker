class CreateSectionPageSectionContents < ActiveRecord::Migration
  def change
    create_table :section_page_section_contents do |t|
      t.boolean :article
      t.boolean :multiple_media
      t.boolean :single_media
      t.boolean :video
      t.boolean :static
      t.boolean :override_headline_title
      t.boolean :override_description
      t.boolean :override_image
      t.boolean :no_byline
      t.string :title
      t.text :description
      t.references :section_page_section
      t.references :article
      t.references :medium
      t.references :media_collection
      t.integer :position
      t.timestamps null: false
    end
  end
end
