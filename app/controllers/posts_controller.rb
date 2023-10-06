class PostsController < ApplicationController
  before_action :set_user, only: %i[show index]
  before_action :set_post, only: %i[show]
  before_action :set_current_user, only: %i[new create]

  # # GET /posts or /posts.json
  def index
    @posts = @user.posts.order(created_at: 'desc')
  end

  # # GET /posts/1 or /posts/1.json
  def show; end

  def new; end

  def create
    @new_post = Post.new(post_params)
    @new_post.author_id = @current_user.id

    if @new_post.save
      redirect_to "/users/#{@new_post.author_id}"
    else
      render :new
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

  def set_current_user
    @current_user = current_user
  end
end
