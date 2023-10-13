class CommentsController < ApplicationController
  load_and_authorize_resource

  before_action :set_post, only: %i[new create index_api]
  before_action :set_user, only: %i[new]

  # '/users/:user_id/posts/:id/comments/new'
  def new; end

  # '/users/:user_id/posts/:id/comments/create'
  def create
    @new_comment = Comment.new(comment_params)
    @new_comment.user_id = current_user.id
    @new_comment.post_id = @post.id

    if @new_comment.save
      flash[:notice] = 'New comment added successfully!'
      redirect_to "/users/#{@post.author_id}/posts/#{@post.id}"
    else
      render :new
    end
  end

  def destroy
    selected_comment = Comment.find(params[:id])
    return unless selected_comment.destroy

    flash[:success] = 'Comment deleted successfully!'
    redirect_to request.referer
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
