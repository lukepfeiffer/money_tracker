class ChangeDataTypeOfAdjustedDate < ActiveRecord::Migration
  def change
    change_column :money_records, :adjusted_date, :date
  end
end
