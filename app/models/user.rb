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

  validates :username, presence: true,
                       format: { with: /\A[a-zA-Z0-9]+\Z/,
                       message: "^Name must contain only letters and digits." },
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

  # Access token for a user
  def access_token
    User.create_access_token(self)
  end

  # Verifier based on our application secret
  def self.verifier
    ActiveSupport::MessageVerifier.new(NewsPortal::Application.config.secret_key_base)
  end

  # Get a user from a token
  def self.read_access_token(signature)
    id = verifier.verify(signature)
    User.find_by_id id
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    nil
  end

  # Class method for token generation
  def self.create_access_token(user)
    verifier.generate(user.id)
  end

  #Number of users registrated today
  scope :joined_within_one_days, -> { where('created_at >= :five_days_ago',
        :five_days_ago => Time.now.beginning_of_day,) }

  private
    #add a new user role
    def create_role
      self.roles << Role.find_by_name(:user)
    end
end
