class Response < ActiveRecord::Base
  attr_accessible :clue_id, :responded, :result, :user_id

  belongs_to :user
  belongs_to :clue
end
