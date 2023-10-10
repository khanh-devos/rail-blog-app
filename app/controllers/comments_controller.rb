class CommentsController < ApplicationController
  before_action :set_post, only: %i[new create]
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
