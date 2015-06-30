class CreateCarBuyingQuestionships < ActiveRecord::Migration
  def change
    create_table :car_buying_questionships do |t|
      t.integer :car_buying_id
      t.integer :question_id

      t.timestamps
    end
  end
end
