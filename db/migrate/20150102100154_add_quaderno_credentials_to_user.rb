class AddQuadernoCredentialsToUser < ActiveRecord::Migration
  def up
    add_column :users, :access_token, :string
    add_column :users, :refresh_token, :string
    add_column :users, :token_expires_at, :datetime
    add_column :users, :quaderno_id, :integer
    add_column :users, :quaderno_account_id, :integer
    add_column :users, :subscription_id, :integer

    add_index :users, :quaderno_id
    add_index :users, :quaderno_account_id
    add_index :users, :subscription_id
  end

  def down
    remove_column :users, :access_token
    remove_column :users, :refresh_token
    remove_column :users, :token_expires_at
    remove_column :users, :quaderno_id
    remove_column :users, :quaderno_account_id
    remove_column :users, :subscription_id
  end
end
