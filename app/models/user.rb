class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_create :create_quaderno_account

  validates :first_name, presence: true

  def create_quaderno_account
    account_attributes = {
      first_name: first_name,
      last_name: last_name,
      email: email,
      street_line_1: street_line_1,
      street_line_2: street_line_2,
      postal_code: "123558",
      city: city,
      region: region,
      country: country,
      phone_1: phone_1,
      phone_2: phone_2,
      logo_url: "http://img4.wikia.nocookie.net/__cb20131118043005/marvelmovies/images/8/8f/Stark_Industries_logo.png",
      users_attributes: [
        {
          first_name: first_name,
          last_name: last_name,
          email: email,
          language: "EN"
        }
      ]
    }
    create_user_response = HTTParty.post("#{Rails.application.secrets.quaderno_url}/partners/api/v1/accounts.json", body: account_attributes, basic_auth: { username: Rails.application.secrets.quaderno_secret })
    if create_user_response.code == 201
      response = create_user_response.parsed_response.symbolize_keys
      self.assign_attributes({
        access_token: response[:access_token],
        refresh_token: response[:refresh_token],
        refresh_token: response[:token_expires_at],
        quaderno_id: response[:user_id],
        quaderno_account_id: response[:account_id],
        subscription_id: response[:subscription_id]
      })
    else
      false
    end
  end
end
