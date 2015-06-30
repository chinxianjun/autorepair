class CreateComplaintQuestionships < ActiveRecord::Migration
  def change
    create_table :complaint_questionships do |t|
      t.integer :complaint_id
      t.integer :question_id

      t.timestamps
    end
  end
end
