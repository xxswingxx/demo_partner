class UsersController < ApplicationController
  before_action :authenticate_user!
  before_filter :generate_login_url

  def index
    render :index
  end

  private

  def generate_login_url
    jwt_package = JWT.encode({ id: current_user.quaderno_id, iat: Time.now.to_i }, Rails.application.secrets.quaderno_secret)
    @login_url = "#{Rails.application.secrets.quaderno_url}partners/api/v1/accounts/#{current_user.quaderno_account_id}/sessions/create.json?client_id=#{Rails.application.secrets.quaderno_id}&jwt=#{jwt_package}"
  end
end