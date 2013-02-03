class User < ActiveRecord::Base
  has_secure_password

  attr_accessible :username, :password, :password_confirmation

  has_many :responses
  has_many :clues, :through => :responses

  validates :username, :presence => true, :uniqueness => true,
                       :length => { :minimum => 4, :maximum => 30 }
  validates :password, :presence => true, :length => { :minimum => 4, :maximum => 40 },
                       :confirmation => true

  def self.authenticate( username, password )
    user = User.find_by_username( username )
    unless user && user.authenticate( password )
      raise "Username or password invalid"
    end
    user
  end

  def toggle_admin
    self.admin = !self.admin
    save( :validate => false )
  end

  def admin?
    admin
  end

  def responded?( clue_id )
    responses.find_by_clue_id( clue_id )
  end

  def respond!( clue_id, responded, correct )
    last_response = responses.find_by_clue_id( clue_id )
    #Already a response today. Just overwrite it.
    if last_response && last_response.created_at < Time.now.midnight.utc
      last_response.responded = responded
      last_response.correct = correct
      last_response.save
    #Otherwise, create a new one
    else
      responses.create!( :clue_id => clue_id, :responded => responded, :result => correct )
    end
  end

  def responded?( clue_id )
    responses.find_by_clue_id( clue_id )
  end

  def respond!( clue_id, responded, correct )
    last_response = responses.find_by_clue_id( clue_id )
    #Already a response today. Just overwrite it.
    if last_response && last_response.created_at < Time.now.midnight.utc
      last_response.responded = responded
      last_response.correct = correct
      last_response.save
    #Otherwise, create a new one
    else
      responses.create!( :clue_id => clue_id, :responded => responded, :result => correct )
    end
  end

  def get_stats( clues )
    stats = {:total_correct => 0, :total_wrong => 0, :clams_correct => 0, :clams_wrong => 0, :total_answered => 0, :total_clams => 0}
    clues.each do |c|
      s = self.responded?( c.id )
      if s
        if s.responded == true
          if s.result == true
            stats[:total_correct] += 1
          else
            stats[:total_wrong] += 1
          end
          stats[:total_answered] += 1
        else
          if s.result == true
            stats[:clams_correct] += 1
          else
            stats[:clams_wrong] += 1
          end
          stats[:total_clams] += 1
        end
      end
    end
    stats
  end

end
