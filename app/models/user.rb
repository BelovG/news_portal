class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, uniqueness: { :case_sensitive => false },
                       format: { with: /\A[a-zA-Z0-9]+\Z/ },
                       length: {minimum: 3, maximum: 20}
end
