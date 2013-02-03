class CreateClues < ActiveRecord::Migration
  def change
    create_table :clues do |t|
      t.string :clue_text
      t.string :correct_response
      t.string :category
      t.integer :round
      t.integer :value
      t.integer :cell_id
      t.integer :game_id

      t.timestamps
    end
  end
end
