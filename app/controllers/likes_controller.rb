class LikesController < ApplicationController
  before_action :set_post, only: %i[create]

  def create
    @new_like = Like.new(user_id: current_user.id, post_id: @post.id)
    @new_like.save
    redirect_to request.referer
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end
end
