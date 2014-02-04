class PostsController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  load_and_authorize_resource except: [:create]

  def index
    @posts = Post.paginate(page: params[:page]).where('approval = true').order('created_at DESC')
  end

  def new
    @post = Post.new
    @categories = Category.all
  end

  def create
    @post = Post.new(post_params)
    @categories = Category.all
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
    find_posts_categories("Policy")
    render 'posts/index'
  end

  def sport
    find_posts_categories("Sport")
    render 'posts/index'
  end

  def culture
    find_posts_categories("Culture")
    render 'posts/index'
  end

  def business
    find_posts_categories("Business")
    render 'posts/index'
  end

  def science
    find_posts_categories("Science")
    render 'posts/index'
  end

  private

    def find_posts_categories(category)
      @posts = Category.find_by(title: category).posts.paginate(page: params[:page])
    end

    def post_params
      params.require(:post).permit(:title, :description, :content, :approval, :category_ids => []).merge!(user_id: current_user.id)
    end
end
