class ApplicationController < ActionController::Base
  include JwtApi

  # before_action :authenticate_request
  before_action :configure_permitted_parameters, if: :devise_controller?

  private
  
  def authenticate_request
    header = request.headers['Authorization']
    header = header.split(" ").last if header
    decoded = jwt_decode(header)
    @current_user = User.find(decoded[:user_id])
  end


  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:role, :name, :bio, :photo, :email, :password, :current_password)
    end

    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:role, :name, :bio, :photo, :email, :password, :current_password)
    end
  end
end
