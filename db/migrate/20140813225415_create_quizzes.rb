class CreateQuizzes < ActiveRecord::Migration
  def change
    create_table :quizzes do |t|
      t.string :title
      t.references :user, index: true
      t.string :tag

      t.timestamps
    end
  end
end
