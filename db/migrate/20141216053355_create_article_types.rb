class CreateArticleTypes < ActiveRecord::Migration
  def change
    create_table :article_types do |t|
      t.string :name
      t.text :summary
      t.text :description
      t.text :layout
      t.timestamps
    end
  end
end
