class ParticipationHasManyShifts < ActiveRecord::Migration
  def change
    remove_column :shifts, :team_id
    remove_column :shifts, :staff_id
    remove_index :shifts, [:period_id, :staff_id]

    add_column :shifts, :participation_id, :integer
    add_index :shifts, :participation_id
    add_index :shifts, [:participation_id, :period_id], unique: true
  end
end
