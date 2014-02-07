class HardWorker
  include Sidekiq::Worker

  def perform(post_id)

  end
end