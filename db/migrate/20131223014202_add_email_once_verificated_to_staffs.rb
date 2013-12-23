class AddEmailOnceVerificatedToStaffs < ActiveRecord::Migration
  def change
    add_column :staffs, :email_once_verificated, :boolean, default: false
  end
end
