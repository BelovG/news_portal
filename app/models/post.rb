class Post < ActiveRecord::Base
  include TheComments::Commentable
  has_and_belongs_to_many :categories
  belongs_to :user
  validates :user_id,     presence: true
  validates :title,       presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { maximum: 400 }
  validates :content,     presence: true, length: { maximum: 4000 }

  # "subscription_mailer" fetches the users who need to send a mail
  def subscription_mailer
    users_id = Subscription.where('category_id in (?)', self.categories.ids).distinct.pluck(:user_id)
    users_id.delete(self.user.id)
    if users_id.any?
      number_elements = ((users_id.size/25.to_f).round == 0 ? 1 : (users_id.size/25.to_f).round)
      users_id.each_slice(number_elements) {|array| UserMailer.delay.subscription(array, self.id) }
    end
  end

  # Denormalization methods
  def commentable_title
    "Undefined Post Title"
  end

  def commentable_url
    "#"
  end

  def commentable_state
    "published"
  end
end
