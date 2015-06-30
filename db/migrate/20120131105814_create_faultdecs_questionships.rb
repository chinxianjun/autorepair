class CreateFaultdecsQuestionships < ActiveRecord::Migration
  def change
    create_table :faultdecs_questionships do |t|
      t.integer :faultdesc_id
      t.integer :question_id
      t.timestamps
    end
  end
end
