class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.string :email,           null: false
      t.string :invitation_code, null: false

      t.timestamps
    end

    add_index :invitations, :email, unique: true
    add_index :invitations, :invitation_code, unique: true
  end
end
