class UsersController < ApplicationController
  before_action :authenticate_user!
  before_filter :generate_jwt_package
  
  def index
    render :index
  end

  private

  def generate_jwt_package
  	@jwt_package = JWT.encode({ id: current_user.quaderno_id }, Rails.application.secrets.quaderno_secret)
  end
end