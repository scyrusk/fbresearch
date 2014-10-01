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

ActiveRecord::Schema.define(version: 20140930190611) do

  create_table "author_publication_links", force: true do |t|
    t.integer  "author_id"
    t.integer  "publication_id"
    t.integer  "order"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "authors", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
    t.string   "fb_profile"
  end

  create_table "publications", force: true do |t|
    t.string   "title"
    t.string   "venue"
    t.text     "summary"
    t.integer  "year"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "link"
    t.text     "abstract"
    t.string   "pdf_link"
  end

  create_table "summaries", force: true do |t|
    t.integer  "publication_id"
    t.text     "content"
    t.string   "worker_id"
    t.string   "hit_id"
    t.string   "assignment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "votes", force: true do |t|
    t.string   "worker_id"
    t.string   "hit_id"
    t.string   "assignment_id"
    t.integer  "summary_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
