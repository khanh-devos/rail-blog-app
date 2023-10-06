class LikesController < ApplicationController
  def create
    @current_user = User.first
    @post = Post.find(params[:id])

    @new_like = Like.new(user_id: @current_user.id, post_id: @post.id)

    @new_like.save
    redirect_to request.referer
  end
end
