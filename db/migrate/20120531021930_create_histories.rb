class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.string :send_man
      t.string :receive_man
      t.text :content
      t.timestamps
    end
  end
end
