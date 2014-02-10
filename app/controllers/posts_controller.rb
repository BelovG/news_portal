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
    if Post.find(params[:id]).approval
      @post = Post.find(params[:id])
      @comments = @post.comments.with_state([:draft, :published])
    else
      render 'posts/not_approved'
    end
  end

  def destroy
    Post.find(params[:id]).destroy
    flash[:success] = 'Post deleted'
    redirect_to root_path
  end

  def category
    category = Category.find_by(title: params[:slug])
    @posts = category.posts.paginate(page: params[:page]).where('approval = true').order('created_at DESC')
    render 'posts/index'
  end

  def send_email
    post = Post.find(params[:id])
    if post.approval
      UserMailer.delay.approval(post.id)
      post.subscription_mailer
    else
      UserMailer.delay.disapproval(post.id)
    end
    redirect_to admin_posts_path
  end

  private
    def post_params
      params.require(:post).permit(:title, :description, :content, :approval, :category_ids => []).merge!(user_id: current_user.id)
    end
end
