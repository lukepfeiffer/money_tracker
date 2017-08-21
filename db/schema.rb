# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170821161117) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.text     "description"
    t.string   "name"
    t.integer  "user_id"
    t.decimal  "amount"
    t.datetime "archived_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "paycheck_percentage"
    t.date     "cycle_date"
    t.decimal  "amount_due"
  end

  create_table "money_records", force: :cascade do |t|
    t.decimal  "amount"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "adjusted_date"
    t.string   "description"
  end

  create_table "paychecks", force: :cascade do |t|
    t.integer  "user_id"
    t.decimal  "amount"
    t.date     "date_received"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "amount_left"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "use_paycheck"
    t.boolean  "confirmed_email", default: false
    t.string   "confirm_token"
    t.boolean  "auto_populate"
  end

end
