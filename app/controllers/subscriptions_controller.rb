class SubscriptionsController < ApplicationController
  before_filter :authenticate_user!
  before_action :all_categories,  only: [:index, :create, :destroy]

  def index
  end

  def create
    @category = Category.find(params[:subscription][:category_id])
    current_user.subscriptions.create!(category_id: @category.id)
  end

  def destroy
    @category = Subscription.find(params[:id]).category
    current_user.subscriptions.find_by(category_id: @category.id).destroy!
  end

  # Before_filters

  def all_categories
    @categories = Category.all
  end

end
