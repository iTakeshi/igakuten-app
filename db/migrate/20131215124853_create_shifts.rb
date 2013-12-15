class CreateShifts < ActiveRecord::Migration
  def change
    create_table :shifts do |t|
      t.references :period, index: true
      t.references :team,   index: true
      t.references :staff,  index: true

      t.timestamps
    end
  end
end
