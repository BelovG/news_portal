class SubscriptionsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @categories = Category.all
  end

  def create
    @category = Category.find(params[:subscription][:category_id])
    current_user.subscriptions.create!(category_id: @category.id)
    respond_to do |format|
      format.html { redirect_to subscriptions_path }
      format.js
    end
  end

  def destroy
    @category = Subscription.find(params[:id]).category
    current_user.subscriptions.find_by(category_id: @category.id).destroy!
    respond_to do |format|
      format.html { redirect_to subscriptions_path }
      format.js
    end
  end

end
