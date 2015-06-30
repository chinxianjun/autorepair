class ChangeReceiveManTypeInHistories < ActiveRecord::Migration
  def change
    change_column :histories, :receive_man, :text
  end
end
