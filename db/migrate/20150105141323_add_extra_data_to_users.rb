class AddExtraDataToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :street_line_1, :string
    add_column :users, :street_line_2, :string
    add_column :users, :city, :string
    add_column :users, :region, :string
    add_column :users, :country, :string
    add_column :users, :phone_1, :string
    add_column :users, :phone_2, :string
    add_column :users, :web, :string
    add_column :users, :tax_id, :string
    add_column :users, :vat_number, :string
  end
end
