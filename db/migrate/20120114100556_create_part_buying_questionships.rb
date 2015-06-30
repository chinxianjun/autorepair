class CreatePartBuyingQuestionships < ActiveRecord::Migration
  def change
    create_table :part_buying_questionships do |t|
      t.integer :part_buying_id
      t.integer :question_id
      t.timestamps
    end
  end
end
