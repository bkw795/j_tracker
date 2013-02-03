class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.integer :user_id
      t.integer :clue_id
      t.boolean :responded
      t.boolean :result

      t.timestamps
    end
  end
end
