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

ActiveRecord::Schema.define(version: 2020_02_09_205753) do

  create_table "movies", force: :cascade do |t|
    t.string "title"
    t.string "year"
    t.string "genre"
    t.string "director"
    t.string "poster"
    t.text "plot"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "imdbid"
  end

  create_table "review_tags", force: :cascade do |t|
    t.integer "review_id"
    t.integer "tag_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.text "content"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "movie_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
  end

end