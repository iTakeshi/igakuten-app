class AddIndexOnPeriods < ActiveRecord::Migration
  def change
    add_index :periods, :begins_at, unique: true
    add_index :periods, :ends_at, unique: true
  end
end
