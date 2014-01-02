class CreateParticipations < ActiveRecord::Migration
  def change
    create_table :participations do |t|
      t.references :team, index: true
      t.references :staff, index: true

      t.timestamps
    end

    add_index :participations, [:team_id, :staff_id], unique: true
  end
end
