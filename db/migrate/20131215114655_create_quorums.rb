class CreateQuorums < ActiveRecord::Migration
  def change
    create_table :quorums do |t|
      t.references :period, index: true
      t.references :team,   index: true
      t.integer :quorum, null: false

      t.timestamps
    end
  end
end
