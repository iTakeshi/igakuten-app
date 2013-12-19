class AddDisplayOrderToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :display_order, :integer
    add_index :teams, [:section_id, :display_order], unique: true
  end
end
