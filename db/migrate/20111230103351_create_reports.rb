class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.string :server_regist_number
      t.string :server_process_number

      t.timestamps
    end
  end
end
