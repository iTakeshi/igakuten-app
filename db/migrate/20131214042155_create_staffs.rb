class CreateStaffs < ActiveRecord::Migration
  def change
    create_table :staffs do |t|
      t.string  :family_name,             null: false
      t.string  :family_name_yomi,        null: false
      t.string  :given_name,              null: false
      t.string  :given_name_yomi,         null: false
      t.integer :grade,                   null: false
      t.integer :gender,                  null: false
      t.string  :phone,                   null: false
      t.string  :email,                   null: false
      t.string  :email_verification_code, null: false
      t.boolean :email_verificated
      t.boolean :provisional

      t.timestamps
    end
    add_index :staffs, :phone,                   unique: true
    add_index :staffs, :email,                   unique: true
    add_index :staffs, :email_verification_code, unique: true
  end
end
