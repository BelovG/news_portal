class Post < ActiveRecord::Base
  has_and_belongs_to_many :categories
  belongs_to :user
  validates :user_id,     presence: true
  validates :title,       presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 140 }
  validates :content,     presence: true, length: { maximum: 2000 }
end
