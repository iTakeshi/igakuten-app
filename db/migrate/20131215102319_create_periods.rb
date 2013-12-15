class CreatePeriods < ActiveRecord::Migration
  def change
    create_table :periods do |t|
      t.references :festival_date, index: true
      t.datetime   :begins_at, null: false
      t.datetime   :ends_at,   null: false

      t.timestamps
    end
  end
end
