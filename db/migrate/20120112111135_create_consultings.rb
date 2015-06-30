class CreateConsultings < ActiveRecord::Migration
  def change
    create_table :consultings do |t|
      t.string :category
      t.text :answer
      t.text :question
      t.string :answerer
      t.string :status

      t.timestamps
    end
  end
end
