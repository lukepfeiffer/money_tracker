class AddAdjustedDateToMoneyRecords < ActiveRecord::Migration
  def change
    add_column :money_records, :adjusted_date, :datetime
  end
end
