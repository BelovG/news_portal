class HardWorker
  include Sidekiq::Worker

  def perform(post_id)
    post = Post.find(post_id)
    if post.approval
      UserMailer.approval(post).deliver
      post.subscription_mailer
    else
      UserMailer.disapproval(post).deliver
    end
  end
end