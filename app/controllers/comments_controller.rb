class CommentsController < ApplicationController
  # '/users/:user_id/posts/:id/comments/new'
  def new
    @post = Post.find(params[:id])
  end

  # '/users/:user_id/posts/:id/comments/create'
  def create
    @post = Post.find(params[:id])
    @current_user = User.first

    @new_comment = Comment.new(comment_params)
    @new_comment.user_id = @current_user.id
    @new_comment.post_id = @post.id

    puts '====================================='
    if @new_comment.save
      redirect_to "/users/#{@post.author_id}/posts/#{@post.id}"
    else
      render :new
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
