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

ActiveRecord::Schema.define(version: 20140318021558) do

  create_table "festival_dates", force: true do |t|
    t.integer  "day",        null: false
    t.date     "date",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "festival_dates", ["date"], name: "index_festival_dates_on_date", unique: true
  add_index "festival_dates", ["day"], name: "index_festival_dates_on_day", unique: true

  create_table "invitations", force: true do |t|
    t.string   "email",           null: false
    t.string   "invitation_code", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "accepted"
  end

  add_index "invitations", ["email"], name: "index_invitations_on_email", unique: true
  add_index "invitations", ["invitation_code"], name: "index_invitations_on_invitation_code", unique: true

  create_table "mailing_list_archives", force: true do |t|
    t.integer  "mailing_list_id"
    t.integer  "staff_id"
    t.string   "subject"
    t.text     "body"
    t.text     "raw_source"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "mailing_list_archives", ["mailing_list_id"], name: "index_mailing_list_archives_on_mailing_list_id"
  add_index "mailing_list_archives", ["staff_id"], name: "index_mailing_list_archives_on_staff_id"

  create_table "mailing_lists", force: true do |t|
    t.string   "account_name", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "mailing_lists", ["account_name"], name: "index_mailing_lists_on_account_name", unique: true

  create_table "mailing_lists_teams", id: false, force: true do |t|
    t.integer "mailing_list_id"
    t.integer "team_id"
  end

  add_index "mailing_lists_teams", ["mailing_list_id", "team_id"], name: "index_mailing_lists_teams_on_mailing_list_id_and_team_id", unique: true

  create_table "participations", force: true do |t|
    t.integer  "team_id"
    t.integer  "staff_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "participations", ["staff_id"], name: "index_participations_on_staff_id"
  add_index "participations", ["team_id", "staff_id"], name: "index_participations_on_team_id_and_staff_id", unique: true
  add_index "participations", ["team_id"], name: "index_participations_on_team_id"

  create_table "periods", force: true do |t|
    t.integer  "festival_date_id"
    t.datetime "begins_at",        null: false
    t.datetime "ends_at",          null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "periods", ["begins_at"], name: "index_periods_on_begins_at", unique: true
  add_index "periods", ["ends_at"], name: "index_periods_on_ends_at", unique: true
  add_index "periods", ["festival_date_id"], name: "index_periods_on_festival_date_id"

  create_table "quorums", force: true do |t|
    t.integer  "period_id"
    t.integer  "team_id"
    t.integer  "quorum",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "quorums", ["period_id", "team_id"], name: "index_quorums_on_period_id_and_team_id", unique: true
  add_index "quorums", ["period_id"], name: "index_quorums_on_period_id"
  add_index "quorums", ["team_id"], name: "index_quorums_on_team_id"

  create_table "sections", force: true do |t|
    t.string   "name",          null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "display_order"
  end

  add_index "sections", ["display_order"], name: "index_sections_on_display_order", unique: true
  add_index "sections", ["name"], name: "index_sections_on_name", unique: true

  create_table "shifts", force: true do |t|
    t.integer  "period_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "participation_id"
  end

  add_index "shifts", ["participation_id", "period_id"], name: "index_shifts_on_participation_id_and_period_id", unique: true
  add_index "shifts", ["participation_id"], name: "index_shifts_on_participation_id"
  add_index "shifts", ["period_id"], name: "index_shifts_on_period_id"

  create_table "staffs", force: true do |t|
    t.string   "family_name",                             null: false
    t.string   "family_name_yomi",                        null: false
    t.string   "given_name",                              null: false
    t.string   "given_name_yomi",                         null: false
    t.integer  "grade",                                   null: false
    t.integer  "gender",                                  null: false
    t.string   "phone",                                   null: false
    t.string   "email",                                   null: false
    t.string   "email_verification_code",                 null: false
    t.boolean  "email_verificated"
    t.boolean  "provisional"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "email_once_verificated",  default: false
  end

  add_index "staffs", ["email"], name: "index_staffs_on_email", unique: true
  add_index "staffs", ["email_verification_code"], name: "index_staffs_on_email_verification_code", unique: true
  add_index "staffs", ["phone"], name: "index_staffs_on_phone", unique: true

  create_table "teams", force: true do |t|
    t.integer  "section_id",    null: false
    t.string   "name",          null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "display_order"
  end

  add_index "teams", ["name"], name: "index_teams_on_name", unique: true
  add_index "teams", ["section_id", "display_order"], name: "index_teams_on_section_id_and_display_order", unique: true
  add_index "teams", ["section_id"], name: "index_teams_on_section_id"

end
