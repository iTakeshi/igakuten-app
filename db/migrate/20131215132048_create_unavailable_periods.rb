class CreateUnavailablePeriods < ActiveRecord::Migration
  def change
    create_table :unavailable_periods do |t|
      t.references :staff,  index: true
      t.references :period, index: true

      t.timestamps
    end
  end
end
