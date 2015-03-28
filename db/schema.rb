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

ActiveRecord::Schema.define(version: 20150328083809) do

  create_table "article_tags", force: :cascade do |t|
    t.integer  "tag_id",     limit: 4
    t.integer  "article_id", limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "article_types", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.string   "preview_image", limit: 255
    t.text     "summary",       limit: 65535
    t.text     "description",   limit: 65535
    t.text     "layout",        limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "articles", force: :cascade do |t|
    t.integer  "user_id",                      limit: 4
    t.integer  "article_type_id",              limit: 4
    t.integer  "section_id",                   limit: 4
    t.integer  "featured_media_id",            limit: 4
    t.integer  "score",                        limit: 4
    t.integer  "importance",                   limit: 4
    t.boolean  "featured_media_is_collection", limit: 1,     default: false
    t.boolean  "published",                    limit: 1,     default: false
    t.boolean  "private",                      limit: 1,     default: false
    t.boolean  "disable_comments",             limit: 1,     default: false
    t.string   "headline",                     limit: 255
    t.string   "subheading",                   limit: 255
    t.text     "summary",                      limit: 65535
    t.text     "contents",                     limit: 65535
    t.text     "raw_contents",                 limit: 65535
    t.text     "raw_sass",                     limit: 65535
    t.text     "custom_sass",                  limit: 65535
    t.string   "slug",                         limit: 255
    t.datetime "published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "formatted_writers_names",      limit: 65535
    t.string   "short_url",                    limit: 255
  end

  create_table "media", force: :cascade do |t|
    t.boolean  "video",                limit: 1
    t.integer  "user_id",              limit: 4
    t.string   "filename",             limit: 255
    t.string   "title",                limit: 255
    t.string   "credit",               limit: 255
    t.string   "mime_type",            limit: 255
    t.string   "s3_key",               limit: 255
    t.string   "one_to_one_crop",      limit: 255
    t.string   "three_to_two_crop",    limit: 255
    t.string   "four_to_three_crop",   limit: 255
    t.string   "sixteen_to_nine_crop", limit: 255
    t.integer  "image_width",          limit: 4
    t.integer  "image_height",         limit: 4
    t.text     "link",                 limit: 65535
    t.text     "secure_link",          limit: 65535
    t.text     "caption",              limit: 65535
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.boolean  "pending_initial_edit", limit: 1,     default: true
    t.boolean  "watermark",            limit: 1
  end

  create_table "media_collection_contents", force: :cascade do |t|
    t.integer  "media_collection_id", limit: 4
    t.integer  "medium_id",           limit: 4
    t.boolean  "override_caption",    limit: 1
    t.text     "caption",             limit: 65535
    t.integer  "position",            limit: 4
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "media_collections", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "section_page_section_contents", force: :cascade do |t|
    t.boolean  "article",                 limit: 1
    t.boolean  "multiple_media",          limit: 1
    t.boolean  "single_media",            limit: 1
    t.boolean  "video",                   limit: 1
    t.boolean  "static",                  limit: 1
    t.boolean  "override_headline_title", limit: 1
    t.boolean  "override_description",    limit: 1
    t.boolean  "override_image",          limit: 1
    t.boolean  "no_byline",               limit: 1
    t.string   "title",                   limit: 255
    t.text     "description",             limit: 65535
    t.integer  "section_page_section_id", limit: 4
    t.integer  "article_id",              limit: 4
    t.integer  "medium_id",               limit: 4
    t.integer  "media_collection_id",     limit: 4
    t.integer  "position",                limit: 4
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  create_table "section_page_sections", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.string   "subtitle",   limit: 255
    t.string   "type_name",  limit: 255
    t.string   "type_slug",  limit: 255
    t.integer  "position",   limit: 4
    t.integer  "section_id", limit: 4
    t.boolean  "static",     limit: 1
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "sections", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "short_name", limit: 255
    t.string   "slug",       limit: 255
    t.string   "fa_icon",    limit: 255
    t.boolean  "private",    limit: 1
    t.integer  "parent_id",  limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider",               limit: 255,                null: false
    t.string   "uid",                    limit: 255,   default: "", null: false
    t.string   "encrypted_password",     limit: 255,   default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.string   "name",                   limit: 255
    t.string   "nickname",               limit: 255
    t.string   "image",                  limit: 255
    t.string   "email",                  limit: 255
    t.text     "tokens",                 limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username",               limit: 255
    t.string   "first_name",             limit: 255
    t.string   "last_name",              limit: 255
    t.boolean  "staff",                  limit: 1
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true, using: :btree

  create_table "writer_articles", force: :cascade do |t|
    t.integer  "article_id", limit: 4
    t.integer  "writer_id",  limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "writers", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "slug",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

end
