class AddPendingInitialEditColumnToMediaTable < ActiveRecord::Migration
  def change
    add_column :media, :pending_initial_edit, :boolean, default: true
  end
end
