class CreateGames < ActiveRecord::Migration

  def change
    create_table :games do |t|
      t.integer :show_id
      t.datetime :airdate
      t.string :categories

      t.timestamps
    end
  end

end
