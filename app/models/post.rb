class Post < ActiveRecord::Base
  belongs_to :user
  has_many :votes, as: :voteable, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  before_save :categorize
  after_create :add_karma
  
  POST_TYPES = ['ask', 'show', 'default']
  validates :post_type, :presence => true, :inclusion => { :in => POST_TYPES }
  validates :url, :url => true, presence: true, if: :text_blank?
  validates :title, presence: true
  validates :text, presence: true, if: :url_blank?
  
  def text_blank?
    self.text.length == 0
  end
  
  def url_blank?
    self.url.length == 0
  end

  # Hacker News popularity algorithm, popularity based on function of time
  def self.popular
    Post.select("posts.*, (((posts.votes_count) / POW(((EXTRACT(EPOCH FROM (now()-posts.created_at)) / 3600)::integer + 2), 1.5))) AS popularity")
        .order("popularity DESC")
  end
  
  def is_duplicate_link?
  end
  
  # We use this method to determine if a post is an "Ask PR:" or a "Show PR:" based on the first
  # few words in the posts title. I like to call this smart filtering.
  def find_post_type_from_string(prefix)
    if self.title.downcase.scan(prefix).count > 0
      if self.title.downcase.index(prefix) == 0
        return true
      end
    end
  end
  
  def is_show_pr?
    self.find_post_type_from_string("show fh:")
  end
  
  def is_ask_pr?
    self.find_post_type_from_string("ask fh:")
  end
  
  def edit_post(type)
    self.title = self.title.gsub("#{type} fh: ", "#{type.capitalize} FH: ") 
    self.post_type = type
  end
  
  def categorize
    if self.is_show_pr?
      self.edit_post("show")
    end
    if self.is_ask_pr?
      self.edit_post("ask")
    end
  end
  
  # Create one vote from the user that submitted the post.  This
  # helps the popularity algorithm by giving the time variable
  # a nonzero karma value to multiply against.
  def add_karma
    self.user.votes.build(:voteable_id => self.id, :voteable_type => "Post", :vote_type => "Up").save!
  end
end
