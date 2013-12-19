class AddDisplayOrderToSections < ActiveRecord::Migration
  def change
    add_column :sections, :display_order, :integer
    add_index :sections, :display_order, unique: true
  end
end
