class CommentsController < ApplicationController
  # GET /comments or /comments.json
  def index; end

  # GET /comments/1 or /comments/1.json
  def show; end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = comment.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def comment_params
    params.require(:comment).permit(:user_id, :post_id)
  end
end
