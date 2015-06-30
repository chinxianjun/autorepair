class CreateRepairs < ActiveRecord::Migration
  def change
    create_table :repairs do |t|
      t.string :service_number

      t.timestamps
    end
  end
end
