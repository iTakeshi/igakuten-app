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

ActiveRecord::Schema.define(version: 20131215101650) do

  create_table "festival_dates", force: true do |t|
    t.integer  "day",        null: false
    t.date     "date",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "festival_dates", ["date"], name: "index_festival_dates_on_date", unique: true
  add_index "festival_dates", ["day"], name: "index_festival_dates_on_day", unique: true

  create_table "sections", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sections", ["name"], name: "index_sections_on_name", unique: true

  create_table "staffs", force: true do |t|
    t.string   "family_name",             null: false
    t.string   "family_name_yomi",        null: false
    t.string   "given_name",              null: false
    t.string   "given_name_yomi",         null: false
    t.integer  "grade",                   null: false
    t.integer  "gender",                  null: false
    t.string   "phone",                   null: false
    t.string   "email",                   null: false
    t.string   "email_verification_code", null: false
    t.boolean  "email_verificated"
    t.boolean  "provisional"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "staffs", ["email"], name: "index_staffs_on_email", unique: true
  add_index "staffs", ["email_verification_code"], name: "index_staffs_on_email_verification_code", unique: true
  add_index "staffs", ["phone"], name: "index_staffs_on_phone", unique: true

  create_table "teams", force: true do |t|
    t.integer  "section_id", null: false
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "teams", ["name"], name: "index_teams_on_name", unique: true
  add_index "teams", ["section_id"], name: "index_teams_on_section_id"

end
