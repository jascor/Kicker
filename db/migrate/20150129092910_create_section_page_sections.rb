class CreateSectionPageSections < ActiveRecord::Migration
  def change
    create_table :section_page_sections do |t|
      t.string :title
      t.string :subtitle
      t.string :type_name
      t.string :type_slug
      t.integer :position
      t.references :section
      t.boolean :static
      t.timestamps null: false
    end
  end
end