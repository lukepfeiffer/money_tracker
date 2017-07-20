class AddDescriptionToMoneyRecord < ActiveRecord::Migration
  def change
    add_column :money_records, :description, :string
  end
end
