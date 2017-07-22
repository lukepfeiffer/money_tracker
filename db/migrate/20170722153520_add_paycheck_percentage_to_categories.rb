class AddPaycheckPercentageToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :paycheck_percentage, :decimal
  end
end
