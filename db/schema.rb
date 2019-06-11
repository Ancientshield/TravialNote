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

ActiveRecord::Schema.define(version: 2019_06_11_070931) do

  create_table "diaries", force: :cascade do |t|
    t.datetime "diary_date"
    t.integer "user_id"
    t.text "content"
    t.json "location"
    t.boolean "is_editing", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "diary_tags", force: :cascade do |t|
    t.integer "diary_id"
    t.integer "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pictures", force: :cascade do |t|
    t.integer "diary_id"
    t.json "pic_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pocket_lists", force: :cascade do |t|
    t.datetime "expect_date"
    t.json "location"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string "label"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
