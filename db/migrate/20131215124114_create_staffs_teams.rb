class CreateStaffsTeams < ActiveRecord::Migration
  def change
    create_join_table :staffs, :teams do |t|
      t.index :staff_id
      t.index :team_id
    end
  end
end
