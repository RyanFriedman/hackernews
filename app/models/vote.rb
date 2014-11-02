class Vote < ActiveRecord::Base
  belongs_to :voteable, polymorphic: true, counter_cache: true
  
  after_create :increment_user_karma
  
  VOTEABLE_TYPES = ['Post', 'Comment']
  validates :voteable_type, :presence => true, :inclusion => { :in => VOTEABLE_TYPES }
    
  # A user can earn karam when either a post or comment they
  # submitted receives a vote.  Their karma is the cumulative
  # total of all their comments and posts votes.
  def increment_user_karma
    self.voteable.user.karma += 1
    self.voteable.save!
  end
  
end
