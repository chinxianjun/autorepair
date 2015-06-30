class AddUsernameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :fullname, :string
    add_column :users, :user_number, :string
    add_column :users, :phone, :string
    add_column :users, :birthday, :date
    add_column :users, :address, :string
  end
end
