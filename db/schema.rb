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

ActiveRecord::Schema.define(version: 20160312075035) do

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",               limit: 255, default: "", null: false
    t.string   "encrypted_password",  limit: 255, default: "", null: false
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",       limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",  limit: 255
    t.string   "last_sign_in_ip",     limit: 255
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree

  create_table "circle_points", force: :cascade do |t|
    t.integer  "circle_id",  limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "rule1",      limit: 255
    t.string   "rule2",      limit: 255
    t.string   "appeal1",    limit: 255
    t.string   "appeal2",    limit: 255
    t.string   "appeal3",    limit: 255
  end

  create_table "circles", force: :cascade do |t|
    t.integer  "user_id",         limit: 4
    t.integer  "circle_genre_id", limit: 4
    t.string   "campus",          limit: 255
    t.string   "name",            limit: 255
    t.string   "name_kana",       limit: 255
    t.string   "email",           limit: 255
    t.string   "show_email",      limit: 255
    t.string   "phone",           limit: 13
    t.boolean  "phone_possible",                default: false, null: false
    t.string   "chief",           limit: 255
    t.string   "chief_kana",      limit: 255
    t.string   "sub_chief",       limit: 255
    t.integer  "member_male",     limit: 4,     default: 0,     null: false
    t.integer  "member_female",   limit: 4,     default: 0,     null: false
    t.integer  "since",           limit: 4
    t.string   "entrance_fee",    limit: 255
    t.string   "annual_fee",      limit: 255
    t.string   "active_weeks",    limit: 255
    t.string   "active_times",    limit: 255
    t.string   "hangout",         limit: 255
    t.string   "location",        limit: 255
    t.string   "camp",            limit: 255
    t.integer  "join_grades",     limit: 4
    t.string   "appeal",          limit: 255
    t.text     "pr",              limit: 65535
    t.string   "booth",           limit: 255
    t.string   "hp",              limit: 255
    t.string   "twitter",         limit: 255
    t.boolean  "facebook",                      default: false, null: false
    t.integer  "status",          limit: 4,     default: 1,     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "e_circles", force: :cascade do |t|
    t.integer  "circle_genre_id", limit: 4
    t.string   "campus",          limit: 255
    t.string   "name",            limit: 255
    t.string   "name_kana",       limit: 255
    t.string   "email",           limit: 255
    t.string   "phone",           limit: 13
    t.boolean  "phone_possible",                default: false, null: false
    t.string   "chief",           limit: 255
    t.string   "chief_kana",      limit: 255
    t.string   "sub_chief",       limit: 255
    t.integer  "member_male",     limit: 4,     default: 0,     null: false
    t.integer  "member_female",   limit: 4,     default: 0,     null: false
    t.integer  "since",           limit: 4
    t.string   "entrance_fee",    limit: 255
    t.string   "annual_fee",      limit: 255
    t.string   "active_weeks",    limit: 255
    t.string   "active_times",    limit: 255
    t.string   "hangout",         limit: 255
    t.string   "location",        limit: 255
    t.string   "camp",            limit: 255
    t.integer  "join_grades",     limit: 4
    t.string   "appeal",          limit: 255
    t.text     "pr",              limit: 65535
    t.string   "hp",              limit: 255
    t.string   "twitter",         limit: 255
    t.boolean  "facebook",                      default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "event_terms", force: :cascade do |t|
    t.date     "start_date"
    t.date     "finish_date"
    t.integer  "status",      limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: :cascade do |t|
    t.date     "date"
    t.integer  "event_type_id", limit: 4
    t.string   "meeting_place", limit: 255
    t.datetime "meeting_time"
    t.integer  "fee",           limit: 4
    t.string   "place",         limit: 255
    t.text     "appeal",        limit: 65535
    t.integer  "circle_id",     limit: 4
    t.integer  "event_term_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "genres", force: :cascade do |t|
    t.integer  "lg_genre_id", limit: 4
    t.string   "name",        limit: 255
    t.string   "type",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lg_genres", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "likes", force: :cascade do |t|
    t.integer  "circle_id",  limit: 4
    t.integer  "user_id",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "points", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "nickname",               limit: 255
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.integer  "status",                 limit: 4,   default: 0,  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "rule_confirmed"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
