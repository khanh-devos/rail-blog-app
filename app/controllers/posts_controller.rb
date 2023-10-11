class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[create destroy]

  before_action :set_user, only: %i[show index destroy]
  before_action :set_post, only: %i[show destroy]

  # # GET /posts or /posts.json
  def index
    @posts = @user.posts.includes(:comments).order(created_at: 'desc')
  end

  # # GET /posts/1 or /posts/1.json
  def show; end

  def new; end

  def create
    @new_post = Post.new(post_params)
    @new_post.author_id = current_user.id

    if @new_post.save
      flash[:success] = 'Post created successfully!'
      redirect_to "/users/#{@new_post.author_id}"
    else
      render :new, alert: 'Failed to like the post.'
    end
  end

  

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:user_id])
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
