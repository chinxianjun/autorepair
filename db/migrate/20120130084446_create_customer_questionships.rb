class CreateCustomerQuestionships < ActiveRecord::Migration
  def change
    create_table :customer_questionships do |t|
      t.integer :customer_id
      t.integer :question_id
      t.timestamps
    end
  end
end
