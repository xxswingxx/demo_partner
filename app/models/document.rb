class Document
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :number, :issue_date, :type, :item_description, :item_quantity, :item_unit_price, :contact_id, :currency

  validates_presence_of  :type, :item_description, :item_quantity, :item_unit_price, :contact_id, :currency

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value) if respond_to?(name)
    end
  end

  def attributes
   {
      currency: currency,
      number: number,
      issue_date: issue_date,
      contact_id: contact_id,
      items_attributes: [
        {
          description: item_description,
          quantity: item_quantity,
          unit_price: item_unit_price
        }
      ]
    }
  end

  def persisted?
    false
  end
end