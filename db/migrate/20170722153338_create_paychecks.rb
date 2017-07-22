class CreatePaychecks < ActiveRecord::Migration
  def change
    create_table :paychecks do |t|
      t.integer :user_id
      t.decimal :amount
      t.date :date_received
      t.timestamps
    end
  end
end
