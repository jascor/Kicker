class AddWatermarkColumnToMedium < ActiveRecord::Migration
  def change
    add_column :media, :watermark, :boolean
  end
end
