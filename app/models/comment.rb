class Comment < ActiveRecord::Base
  acts_as_tree
  belongs_to :user
  belongs_to :post, counter_cache: true
  has_many :votes, as: :voteable, dependent: :destroy
  
  # Hacker News popularity algorithm, popularity based on function of time
  def self.popular
    Comment.select("comments.*, (((comments.votes_count) / POW(((EXTRACT(EPOCH FROM (now()-comments.created_at)) / 3600)::integer + 2), 1.5))) AS popularity")
           .order("popularity DESC")
  end
end
