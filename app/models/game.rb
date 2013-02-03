class Game < ActiveRecord::Base
  has_many :clues
  attr_accessible :show_id, :categories, :airdate

end
