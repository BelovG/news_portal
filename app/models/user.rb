class User < ActiveRecord::Base
  include TheComments::User
  has_many :users_roles
  has_many :roles, :through => :users_roles
  has_many :subscriptions
  has_many :categories, :through => :subscriptions
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

  def subscribe(category)
    self.categories << Category.find_by(title: category)
  end

  def unsubscribe(category)
    self.categories >> Category.find_by(title: category)
  end

  def subscribed?(category)
    self.subscriptions.find_by(category_id: category.id)
  end

  def comments_admin?
  end

  def comments_moderator? comment
    id == comment.holder_id
  end

  scope :joined_within_one_days, -> { where('created_at >= :five_days_ago',
        :five_days_ago => Time.now.beginning_of_day,) }

  private
  def create_role
    self.roles << Role.find_by_name(:user)
  end

end
