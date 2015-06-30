class ChangeEmailToAdmins < ActiveRecord::Migration
  def change
    change_column :admins, :email, :string, :null => true
  end
end
