class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  validates :username, :uniqueness => {
             :case_sensitive => false
           }
        
  attr_accessor :login
    
  has_many :posts
  has_many :comments
  has_many :votes
  
  def voted_on_post?(post)
    Vote.where(:user_id => self.id, :voteable_type => "Post", :voteable_id => post.id).count > 0
  end
  
  # Devise override for allowing users to sign in with username or email
  # https://github.com/plataformatec/devise/wiki/How-To:-Allow-users-to-sign-in-using-their-username-or-email-address
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end
  
  def admin?
    self.admin == true
  end
  
  def email_required?
    false
  end

  def email_changed?
    false
  end
end
