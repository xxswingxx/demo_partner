class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_create :create_quaderno_account

  def create_quaderno_account
    account_attributes = {
      first_name: ['Stark Industries', 'Niels', 'Anthony', 'Richard', 'Natalie', 'Marie', 'Betsy'],
      last_name: %w(Grey Mulligan Stark Cobblepot Frey).sample,
      kind: %w(person company).sample,
      email: email,
      street_line_1: "something",
      street_line_2: "something",
      postal_code: "123558",
      city: "New York City",
      region: "New York",
      country: %w(US ES DE GB FR IR CH CA).sample,
      phone_1: "",
      phone_2: "",
      logo_url: "http://stark-industries.com/assets/logo-1.png",
      users_attributes: [
        {
          first_name: "Tony",
          last_name: "Stark",
          email: email,
          language: "EN"
        }
      ]
    }
    create_user_response = HTTParty.post('http://lvh.me:3000/partners/api/v1/accounts.json', body: account_attributes, basic_auth: { username: Rails.application.secrets.quaderno_secret })
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
