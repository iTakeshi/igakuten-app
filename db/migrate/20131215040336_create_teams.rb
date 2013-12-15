class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.integer :section_id, null: false
      t.string  :name,       null: false

      t.timestamps
    end
    add_index :teams, :section_id
    add_index :teams, :name, unique: true
  end
end
