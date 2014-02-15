class PostsController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :send_email]
  before_filter :get_posts, only: [:category, :destroy]
  before_filter :find_post, only: [:edit, :update, :show, :destroy, :send_email]
  before_filter :get_categories, only: [:new, :create, :edit]
  load_and_authorize_resource except: [:create]

  def category
    render 'posts/index'
  end

  def new
    @post = Post.new
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
  end

  def update
    params[:post][:category_ids] ||= []
    if @post.update_attributes(post_params)
      flash[:success] = 'Post successfully updated!'
      redirect_to post_path(@post)
    else
      render 'edit'
    end
  end

  def show
    if @post.approval
      @comments = @post.comments.with_state([:draft, :published])
    else
      render 'posts/not_approved'
    end
  end

  def destroy
    @post.destroy
    flash.now[:success] = 'Post deleted'
    respond_to do |format|
      format.js
    end
  end

  def send_email
    if @post.approval
      UserMailer.delay.approval(@post.id)
      @post.subscription_mailer
    else
      UserMailer.delay.disapproval(@post.id)
    end
    redirect_to admin_posts_path
  end

  # Before_filters
  def get_posts
    if params[:slug]
      category = Category.find_by(title: params[:slug])
      @posts = category.posts.paginate(page: params[:page]).where('approval = true').order('created_at DESC')
    else
      @posts = Post.paginate(page: params[:page]).where('approval = true').order('created_at DESC')
    end
  end

  def find_post
    @post = Post.find(params[:id])
  end

  def get_categories
    @categories = Category.all
  end

  private
    def post_params
      params.require(:post).permit(:title, :description, :content, :approval, :category_ids => []).merge!(user_id: current_user.id)
    end
end
