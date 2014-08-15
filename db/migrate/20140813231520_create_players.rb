class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.references :quiz, index: true
      t.references :user, index: true
      t.integer :score
      t.integer :progress

      t.timestamps
    end
  end
end
