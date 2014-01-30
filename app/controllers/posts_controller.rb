class PostsController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]


  def new
    @post = Post.new
    @categories = Category.all
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:success] = 'Post successfully created'
      redirect_to post_path(@post)
    else
      render 'new'
    end
  end

  def edit
    @post = Post.find(params[:id])
    @categories = Category.all
  end

  def update
    params[:post][:category_ids] ||= []
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      flash[:success] = 'Post successfully updated!'
      redirect_to post_path(@post)
    else
      render 'edit'
    end
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.with_state([:draft, :published])
  end

  def destroy
    Post.find(params[:id]).destroy
    flash[:success] = 'Post deleted'
    redirect_to root_path
  end

  def policy
    @posts = Category.find_by(title: "Policy").posts.paginate(page: params[:page])
    render 'static_pages/home'
  end

  def sport
    @posts = Category.find_by(title: "Sport").posts.paginate(page: params[:page])
    render 'static_pages/home'
  end

  def culture
    @posts = Category.find_by(title: "Culture").posts.paginate(page: params[:page])
    render 'static_pages/home'
  end

  def business
    @posts = Category.find_by(title: "Business").posts.paginate(page: params[:page])
    render 'static_pages/home'
  end

  def science
    @posts = Category.find_by(title: "Science").posts.paginate(page: params[:page])
    render 'static_pages/home'
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :content, :approval, :category_ids => []).merge!(user_id: current_user.id)
  end

end
