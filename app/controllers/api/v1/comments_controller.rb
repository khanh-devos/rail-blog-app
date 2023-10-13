class Api::V1::CommentsController < ApplicationController
  load_and_authorize_resource except: %i[create]
  skip_before_action :verify_authenticity_token

  def index
    @post = Post.find(params[:post_id])
    @comments = @post.comments
    render json: { 
      success: true, 
      data: { 
          post: @post,
          comments: @comments
        } 
      }
  end

  def create
    @current_user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])

    @comment = Comment.new(text: params[:text])
    @comment.user_id = @current_user.id
    @comment.post_id = @post.id

    if @comment.save
      render json: { success: true, data: { comment: @comment, user: @current_user } }, status: :created
    else
      render json: { success: false, errors: @comment.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
