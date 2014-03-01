class CreateMailingLists < ActiveRecord::Migration
  def change
    create_table :mailing_lists do |t|
      t.string :account_name, null: false

      t.timestamps
    end

    add_index :mailing_lists, :account_name, unique: true
  end
end
