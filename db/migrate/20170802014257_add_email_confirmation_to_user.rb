class AddEmailConfirmationToUser < ActiveRecord::Migration
  def change
    add_column :users, :confirmed_email, :boolean, default: false
    add_column :users, :confirm_token, :string
  end
end
