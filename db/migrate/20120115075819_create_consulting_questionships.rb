class CreateConsultingQuestionships < ActiveRecord::Migration
  def change
    create_table :consulting_questionships do |t|
      t.integer :consulting_id
      t.integer :question_id

      t.timestamps
    end
  end
end
