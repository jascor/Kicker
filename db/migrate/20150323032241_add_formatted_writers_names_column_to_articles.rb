class AddFormattedWritersNamesColumnToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :formatted_writers_names, :text
  end
end
