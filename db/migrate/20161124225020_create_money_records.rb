class CreateMoneyRecords < ActiveRecord::Migration
  def change
    create_table :money_records do |t|
      t.decimal :amount
      t.integer :category_id
      t.timestamps
    end
  end
end
