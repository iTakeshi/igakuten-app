class AddIndexOnShifts < ActiveRecord::Migration
  def change
    add_index :shifts, [:period_id, :staff_id], unique: true
  end
end
