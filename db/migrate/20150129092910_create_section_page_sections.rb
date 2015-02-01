class CreateSectionPageSections < ActiveRecord::Migration
  def change
    create_table :section_page_sections do |t|
      t.string :title
      t.string :subtitle
      t.string :type
      t.integer :position
      t.boolean :static
      t.timestamps null: false
    end
  end
end
