class DocumentsController < ApplicationController

  def new
    auth = "Bearer  #{current_user.access_token}"
    @contacts = get_contacts
    @document = Document.new(type: 'invoice', item_quantity: 1)
  end

  def create
    @document = Document.new(document_params)
    if @document.valid?
      response = HTTParty.post "#{Rails.application.secrets.quaderno_url}api/v1/#{@document.type.pluralize}.json", body: @document.attributes, headers: { "Authorization" =>  "Bearer #{current_user.access_token}" }
      if response.code ==  201
        flash[:notice] = 'Document successfully created.'
        return redirect_to users_path
      else
        flash.now[:alert] = response.parsed_response['errors'].try(:first)
      end
    else
      flash.now[:alert] = 'There are some errors…'
    end
    @contacts = get_contacts
    render 'new'
  end

  private
  def document_params
    params.require(:document).permit(:currency, :number, :issue_date, :type, :item_description, :item_quantity, :item_unit_price, :contact_id)
  end

  def get_contacts
    response = HTTParty.get("#{Rails.application.secrets.quaderno_url}api/v1/contacts.json", headers: { "Authorization" => "Bearer #{current_user.access_token}" })
    if response.parsed_response.count.zero?
      flash[:alert] = "Upppss… It seems you don't have any contact. What about creating one now?"
      return redirect_to new_contact_path
    end

    response.parsed_response.map { |contact| [contact['full_name'], contact['id']]}
  end
end