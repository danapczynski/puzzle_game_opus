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

ActiveRecord::Schema.define(version: 2013_12_23_192934) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "blocks", id: :serial, force: :cascade do |t|
    t.string "nickname"
    t.text "shape"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "type"
  end

  create_table "blocks_levels", id: false, force: :cascade do |t|
    t.integer "block_id"
    t.integer "level_id"
  end

  create_table "levels", id: :serial, force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "level_number"
  end

  create_table "scores", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "level_id"
    t.integer "completion_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
  end

end
