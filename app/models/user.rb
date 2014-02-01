class User < ActiveRecord::Base
  include TheComments::User
  has_many :users_roles
  has_many :roles, :through => :users_roles
  has_many :posts, dependent: :destroy
  before_create :create_role

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, uniqueness: { :case_sensitive => false },
                       format: { with: /\A[a-zA-Z0-9]+\Z/ },
                       length: {minimum: 3, maximum: 20}

  def admin?
    self.roles.include?(Role.find_by_name(:admin))
  end

  def comments_admin?
  end

  def comments_moderator? comment
    id == comment.holder_id
  end

  private
  def create_role
    self.roles << Role.find_by_name(:user)
  end

end
