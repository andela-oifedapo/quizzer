class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.references :quiz, index: true
      t.integer :question_number
      t.string :question
      t.string :option_a
      t.string :option_b
      t.string :option_c
      t.string :option_d
      t.string :answer

      t.timestamps
    end
  end
end
