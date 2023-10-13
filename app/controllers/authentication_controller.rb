class AuthenticationController < ApplicationController
    protect_from_forgery except: [:login, :create_api]
    skip_before_action :authenticate_request

    # POST /api/auth/login
    def login
        @user = User.find_by_email(params[:email])
        if @user&.valid_password?(params[:password])
            token = jwt_encode(user_id: @user.id)
            render json: {token: token}, status: :ok
        else
            render json: {error: 'unauthorized'}, status: :unauthorized
        end
    end

end
