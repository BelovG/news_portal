class Category < ActiveRecord::Base
  has_and_belongs_to_many :posts
  has_many :subscriptions
  has_many :users, :through => :subscriptions
  validates :title, uniqueness: { :case_sensitive => false }
end
