class Users::RegistrationsController < Devise::RegistrationsController
  layout 'application'
  before_filter :configure_sign_up_params, only: [:create]
  before_filter :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # You can put the params you want to permit in the empty array.
  def configure_sign_up_params
    [:first_name, :last_name, :street_line_1, :street_line_2, :city, :region, :country, :phone_1, :phone_2, :web, :tax_id, :vat_number, :email, :password, :password_confirmation].each do |custom_field|
      devise_parameter_sanitizer.for(:sign_up) << custom_field
    end
  end

  # You can put the params you want to permit in the empty array.
  def configure_account_update_params
    [:first_name, :last_name, :street_line_1, :street_line_2, :city, :region, :country, :phone_1, :phone_2, :web, :tax_id, :vat_number, :email, :password, :password_confirmation].each do |custom_field|
      devise_parameter_sanitizer.for(:account_update) << custom_field
    end
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
