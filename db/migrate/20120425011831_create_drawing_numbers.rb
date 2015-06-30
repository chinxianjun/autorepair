class CreateDrawingNumbers < ActiveRecord::Migration
  def change
    create_table :drawing_numbers do |t|

      t.timestamps
    end
  end
end
