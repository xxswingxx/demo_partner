class ContactsController < ApplicationController

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new contact_params
    if @contact.valid?
      response = HTTParty.post "#{Rails.application.secrets.quaderno_url}api/v1/contacts.json", body: @contact.attributes, headers: { "Authorization" =>  "Bearer #{current_user.access_token}" }
      if response.code ==  201 
        flash[:notice] = 'Contact successfully created.'
        return redirect_to(users_path)
      else
        flash.now[:alert] = response.parsed_response['errors'].try(:first)
      end
    else
        flash.now[:alert] = 'There are some errors.'
    end
    render 'new'
  end

  private
  def contact_params
    params.require(:contact).permit(:first_name, :last_name, :contact_name,  :street_line_1, :street_line_2, :city, :region, :country, :phone_1, :phone_2, :email, :web, :vat_number, :tax_id)
  end
end