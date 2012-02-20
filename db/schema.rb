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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120218051042) do

  create_table "categories", :force => true do |t|
    t.string   "name_ir"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ancestry"
    t.string   "names_depth_cache_ir"
  end

  add_index "categories", ["ancestry"], :name => "index_categories_on_ancestry"

  create_table "categorizations", :force => true do |t|
    t.integer  "word_id"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "definitions", :force => true do |t|
    t.text     "content"
    t.integer  "word_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "source_id"
  end

  create_table "forms", :force => true do |t|
    t.string   "name"
    t.integer  "word_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locales", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lookups", :force => true do |t|
    t.integer  "verse_id"
    t.integer  "word_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "poems", :force => true do |t|
    t.string   "first_verse", :default => ""
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "initial"
  end

  create_table "signup_tokens", :force => true do |t|
    t.string   "token"
    t.string   "email"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sources", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "translations", :force => true do |t|
    t.string   "key"
    t.string   "value"
    t.integer  "locale_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.integer  "roles_mask"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "userid"
  end

  create_table "verses", :force => true do |t|
    t.integer  "poem_id"
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "pos"
  end

  create_table "words", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
