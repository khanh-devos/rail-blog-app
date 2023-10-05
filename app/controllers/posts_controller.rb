class PostsController < ApplicationController
  before_action :set_user, only: %i[show index]

  # # GET /posts or /posts.json
  def index
    @posts = @user.posts
  end

  # # GET /posts/1 or /posts/1.json
  def show
    @post = Post.find(params[:id])
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:user_id])
  end
end
