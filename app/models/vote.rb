class Vote < ActiveRecord::Base
  belongs_to :voteable, polymorphic: true
  
  after_create :increment_user_karma
  after_create :update_vote_count
  
  VOTEABLE_TYPES = ['Post', 'Comment']
  validates :voteable_type, :presence => true, :inclusion => { :in => VOTEABLE_TYPES }
  
  VOTE_TYPES = ['Up', 'Down']
  validates :vote_type, :presence => true, :inclusion => { :in => VOTE_TYPES }
    
  # A user can earn karma when either a post or comment they
  # submitted receives a vote.  Their karma is the cumulative
  # total of all their comments and posts votes.
  def increment_user_karma
    # Keep users for voting for themselves
    return if self.voteable.user == self.user 
    self.voteable.user.karma += 1
    self.voteable.user.save!
  end
  
  def update_vote_count
    case self.vote_type
    when "Up"
      self.voteable.votes_count += 1
      self.voteable.save!  
    when "Down"
      self.voteable.votes_count -= 1
      self.voteable.save!
    end
  end 
end
