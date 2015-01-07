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

ActiveRecord::Schema.define(version: 20150105141323) do

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "access_token"
    t.string   "refresh_token"
    t.datetime "token_expires_at"
    t.integer  "quaderno_id"
    t.integer  "quaderno_account_id"
    t.integer  "subscription_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "street_line_1"
    t.string   "street_line_2"
    t.string   "city"
    t.string   "region"
    t.string   "country"
    t.string   "phone_1"
    t.string   "phone_2"
    t.string   "web"
    t.string   "tax_id"
    t.string   "vat_number"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["quaderno_account_id"], name: "index_users_on_quaderno_account_id"
  add_index "users", ["quaderno_id"], name: "index_users_on_quaderno_id"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["subscription_id"], name: "index_users_on_subscription_id"

end
