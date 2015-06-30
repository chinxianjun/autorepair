class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :category
      t.string :creator
      t.string :status
      t.string :processor
      t.timestamps
    end
  end
end
