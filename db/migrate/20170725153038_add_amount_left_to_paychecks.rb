class AddAmountLeftToPaychecks < ActiveRecord::Migration
  def change
    add_column :paychecks, :amount_left, :decimal
  end
end
