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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110429170538) do

  create_table "bills", :force => true do |t|
    t.string   "title"
    t.float    "amount"
    t.date     "date"
    t.integer  "user_id"
    t.integer  "friend_id"
    t.float    "user_payed"
    t.float    "friend_payed"
    t.decimal  "user_ratio",   :precision => 3, :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bills", ["friend_id"], :name => "index_bills_on_friend_id"
  add_index "bills", ["user_id"], :name => "index_bills_on_user_id"

  create_table "people", :force => true do |t|
    t.string   "name"
    t.string   "type"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "people", ["email"], :name => "index_people_on_email"
  add_index "people", ["reset_password_token"], :name => "index_people_on_reset_password_token", :unique => true

end
