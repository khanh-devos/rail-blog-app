class Api::V1::UsersController < ApplicationController
  load_and_authorize_resource
  skip_before_action :verify_authenticity_token
  def index
    @users = User.all.order(:created_at)
    render json: { success: true, data: { users: @users } }
  end
end
