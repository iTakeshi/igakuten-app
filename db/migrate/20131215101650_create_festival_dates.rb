class CreateFestivalDates < ActiveRecord::Migration
  def change
    create_table :festival_dates do |t|
      t.integer :day,  null: false
      t.date    :date, null: false

      t.timestamps
    end
    add_index :festival_dates, :day,  unique: true
    add_index :festival_dates, :date, unique: true
  end
end
