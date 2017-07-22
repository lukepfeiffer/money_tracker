class AddUserPaycheckToUser < ActiveRecord::Migration
  def change
    add_column :users, :use_paycheck, :boolean
  end
end
