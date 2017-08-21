class AddCycleDateToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :cycle_date, :date
    add_column :categories, :amount_due, :decimal
  end
end
