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

  def subscription(user_id, post_id)
    @user, @post = User.find(user_id), Post.find(post_id)
    mail(to: @user.email, subject: 'New Post!')
  end

  private
  def finder(post_id)
    @post = Post.find(post_id)
    @user = @post.user
  end
end
