class Contact
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :first_name, :last_name, :contact_name,  :street_line_1, :street_line_2, :city, :region, :country, :phone_1, :phone_2, :email, :web, :vat_number, :tax_id

  validates_presence_of  :first_name

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value) if respond_to?(name)
    end
  end

  def attributes
    JSON.parse(self.to_json).symbolize_keys
  end

  def persisted?
    false
  end
end