class Post < ActiveRecord::Base
  include TheComments::Commentable
  has_and_belongs_to_many :categories
  belongs_to :user
  validates :user_id,     presence: true
  validates :title,       presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 140 }
  validates :content,     presence: true, length: { maximum: 2000 }

  # Denormalization methods
  # Please, read about advanced using
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
