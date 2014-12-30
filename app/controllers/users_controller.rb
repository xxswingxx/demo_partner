class UsersController < ApplicationController
  before_action :authenticate_user!
  before_filter :generate_jwt_package
  
  def index
    render :index
  end

  private

  def generate_jwt_package
  	@jwt_package = JWT.encode({ quaderno_id: 6 }, '5580a1d0e443dcc22466ab12c727b9c01e493114f370a371f2629b2ef04ed008')
  end
end