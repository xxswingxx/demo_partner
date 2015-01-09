class UsersController < ApplicationController
  respond_to :xml, :json, :html
  before_action :authenticate_user!
  before_filter :generate_login_url

  def index
    render :index
  end

  def show
    @user = current_user
  end

  def create_quaderno_subscription
    response = HTTParty.post("#{Rails.application.secrets.quaderno_url}partners/api/v1/accounts/#{current_user.quaderno_account_id}/subscriptions.json", body: { plan: :small }, basic_auth: { username: Rails.application.secrets.quaderno_secret })
    if response.code == 201
      current_user.update_column(:subscription_id, response.parsed_response['id'])
      flash[:notice] = 'Subscription successfully created'
    else
      flash[:alert] = 'Cannot create the subscription'
    end
    redirect_to users_path
  end

  def cancel_quaderno_subscription
    response = HTTParty.delete("#{Rails.application.secrets.quaderno_url}partners/api/v1/accounts/#{current_user.quaderno_account_id}/subscriptions/#{current_user.subscription_id}.json", basic_auth: { username: Rails.application.secrets.quaderno_secret })
    if response.code == 204
      current_user.update_column(:subscription_id, nil)
      flash[:notice] = 'Subscription successfully cancelled'
      redirect_to users_path
    else
      @user = current_user
      flash.now[:alert] = 'Cannot cancel the subscription'
      render 'show'
    end
  end


  private

  def generate_login_url
    jwt_package = JWT.encode({ id: current_user.quaderno_id, iat: Time.now.to_i }, Rails.application.secrets.quaderno_secret)
    @login_url = "#{Rails.application.secrets.quaderno_url}partners/api/v1/accounts/#{current_user.quaderno_account_id}/sessions/create.json?client_id=#{Rails.application.secrets.quaderno_id}&jwt=#{jwt_package}"
  end
end