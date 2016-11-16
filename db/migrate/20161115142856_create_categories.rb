class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.text :description
      t.string :name
      t.integer :user_id
      t.decimal :amount
      t.datetime :archived_at
      t.timestamps
    end
  end
end
