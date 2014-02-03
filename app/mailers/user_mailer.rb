class UserMailer < ActionMailer::Base
  default from: "admin@example.com"

  def approval(post)
    @user = post.user
    @url  = post_url(post)
    mail(to: @user.email, subject: 'Approval!')
  end

  def disapproval(post)
    @user = post.user
    @url  = edit_post_url(post)
    mail(to: @user.email, subject: 'Disapproval!')
  end

  def subscription(user, post)
    @user = user
    @post = post
    @url  = subscriptions_url
    mail(to: @user.email, subject: 'New Post!')
  end
end
