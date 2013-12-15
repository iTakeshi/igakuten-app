class CreateStaffsTeams < ActiveRecord::Migration
  def change
    create_table :staffs_teams do |t|
      t.references :staff, index: true
      t.references :team,  index: true
    end
  end
end
