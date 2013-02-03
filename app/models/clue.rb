class Clue < ActiveRecord::Base
  belongs_to :game
  attr_accessible :clue_text, :correct_response, :category, :value, :round, :cell_id, :game_id

  has_many :categorizations
  has_many :categories, :through => :categorizations

end
