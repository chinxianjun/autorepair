class RenameUsernameTofullname < ActiveRecord::Migration
  rename_column :customers, :username, :fullname
end
