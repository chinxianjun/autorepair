class AddUsernameToAdmins < ActiveRecord::Migration
  def change
    add_column :admins, :user_number, :string
    add_column :admins, :fullname, :string
    add_column :admins, :phone, :string
    add_column :admins, :birthday, :date
    add_column :admins, :address, :string
  end
end