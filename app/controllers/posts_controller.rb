class PostsController < ApplicationController
  before_action :logged_in_user, only: [:index, :new, :create, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  def index
    @posts = Post.all
    flash.keep(:delete)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to user_posts_path(current_user)
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "更新しました"
      session[:updated_post_id] = @post.id
      redirect_to user_posts_path(current_user)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if params[:confirm] == 'true'
      @post.destroy
      redirect_to deleted_user_posts_path(current_user)
    else
      render :confirm_destroy
    end
  end

  def deleted
    flash[:delete] = "削除が完了しました。3秒後に掲示板トップに戻ります。"
  end
  

  def logged_in_user
    unless current_user
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end

  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    redirect_to user_posts_path(current_user) if @post.nil?
  end
end
