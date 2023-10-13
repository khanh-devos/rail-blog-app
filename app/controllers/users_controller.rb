class UsersController < ApplicationController
  # GET /users or /users.json
  def index
    @users = User.all.order(created_at: 'desc')
  end

  def index_api
    @users = User.all.order(created_at: 'desc')
    render json: @users
  end

  # new_user_registration GET    /users/sign_up(.:format)
  def new; end

  def confirmation; end

  # GET /users/1 or /users/1.json
  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def user_sign_out
    sign_out(current_user)
    redirect_to '/'
  end
end
