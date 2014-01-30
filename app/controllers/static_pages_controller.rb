class StaticPagesController < ApplicationController
  def home
    @posts = Post.paginate(page: params[:page]).order('created_at DESC')
    @post = Post.first
  end

  def about

  end
end
