class AddIndexOnStaffsRelatingTables < ActiveRecord::Migration
  def change
    add_index :shifts, [:period_id, :staff_id], unique: true
    add_index :staffs_teams, [:staff_id, :team_id], unique: true
  end
end
