class UserMailer < ActionMailer::Base
  include Sidekiq::Worker
  default from: "admin@example.com"

  def approval(post_id)
    finder(post_id)
    mail(to: @user.email, subject: 'Approval!')
  end

  def disapproval(post_id)
    finder(post_id)
    mail(to: @user.email, subject: 'Disapproval!')
  end

  def subscription(users_id, post_id)
    users, post = User.find(users_id), Post.find(post_id)
    users.each do |user|
      subscription_mailer(user, post)
    end
  end

  def subscription_mailer(user, post)
    @user, @post = user, post
    mail(to: @user.email, subject: 'New Post!')
  end

  private
  def finder(post_id)
    @post = Post.find(post_id)
    @user = @post.user
  end
end
