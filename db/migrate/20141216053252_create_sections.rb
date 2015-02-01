class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.string :name
      t.string :slug
      t.string :fa_icon
      t.boolean :private
      t.references :parent
      t.timestamps
    end
  end
end