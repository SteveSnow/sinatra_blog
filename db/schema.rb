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

ActiveRecord::Schema.define(version: 20160226173303) do

  create_table "Users", force: :cascade do |t|
    t.string   "fname"
    t.string   "lname"
    t.string   "email"
    t.string   "password"
    t.datetime "created_at", default: '2016-02-26 16:56:20'
  end

  create_table "posts", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "message"
    t.datetime "created_at", default: '2016-02-26 16:56:20'
  end

  create_table "userfollows", force: :cascade do |t|
    t.string   "follows_id"
    t.string   "follower_id"
    t.datetime "created_at",  default: '2016-02-26 18:10:14'
  end

end
