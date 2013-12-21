class AddIndexOnQuorums < ActiveRecord::Migration
  def change
    add_index :quorums, [:period_id, :team_id], unique: true
  end
end
