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

ActiveRecord::Schema.define(version: 2018_07_09_204756) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "title"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies", id: :serial, force: :cascade do |t|
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contacts", id: :serial, force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hashtags", force: :cascade do |t|
    t.string "name", null: false
    t.integer "df", default: 0, null: false
    t.bigint "token_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["token_id"], name: "index_hashtags_on_token_id"
  end

  create_table "languages", force: :cascade do |t|
    t.string "name", null: false
    t.integer "df", default: 0, null: false
    t.bigint "token_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["token_id"], name: "index_languages_on_token_id"
  end

  create_table "links", force: :cascade do |t|
    t.string "title"
    t.string "href", null: false
    t.boolean "banned", default: false
    t.integer "df", default: 0, null: false
    t.datetime "publish_at"
    t.bigint "token_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["token_id"], name: "index_links_on_token_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name", null: false
    t.integer "df", default: 0, null: false
    t.bigint "token_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["token_id"], name: "index_locations_on_token_id"
  end

  create_table "mentions", force: :cascade do |t|
    t.string "name", null: false
    t.integer "df", default: 0, null: false
    t.bigint "token_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["token_id"], name: "index_mentions_on_token_id"
  end

  create_table "newsletters", force: :cascade do |t|
    t.string "email"
    t.bigint "token_id", null: false
    t.index ["token_id"], name: "index_newsletters_on_token_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "name"
    t.string "username", null: false
    t.string "image"
    t.string "profile_image"
    t.string "profile_color"
    t.integer "df", default: 0, null: false
    t.integer "tweets_count"
    t.integer "followers_count"
    t.integer "following_count"
    t.bigint "token_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["token_id"], name: "index_profiles_on_token_id"
  end

  create_table "statistics", id: :serial, force: :cascade do |t|
    t.integer "token_id", null: false
    t.float "percent_positive"
    t.float "percent_neutral"
    t.float "percent_negative"
    t.integer "amount"
    t.integer "amount_rated"
    t.integer "user_validate"
    t.integer "user_rated"
    t.integer "user_rated_positive"
    t.integer "user_rated_neutral"
    t.integer "user_rated_negative"
    t.integer "svm_rated"
    t.integer "svm_rated_positive"
    t.integer "svm_rated_neutral"
    t.integer "svm_rated_negative"
    t.integer "tweets_to_delete"
    t.integer "last_3_hours"
    t.integer "last_12_hours"
    t.integer "last_24_hours"
    t.integer "last_3_days"
    t.integer "last_7_days"
    t.integer "positive"
    t.integer "neutral"
    t.integer "negative"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["token_id"], name: "index_statistics_on_token_id"
  end

  create_table "tokens", id: :serial, force: :cascade do |t|
    t.string "uuid", null: false
    t.string "word", null: false
    t.string "lang"
    t.string "accuracy"
    t.boolean "public", default: true
    t.datetime "tf_idf_at"
    t.datetime "svm_rated_at"
    t.datetime "collect_at"
    t.datetime "publish_at"
    t.boolean "enable", default: true
    t.boolean "keep_cron_crawler", default: true
    t.boolean "publishable", default: false
    t.integer "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.string "avatar"
    t.bigint "category_id"
    t.string "status"
    t.index ["category_id"], name: "index_tokens_on_category_id"
    t.index ["uuid"], name: "index_tokens_on_uuid"
    t.index ["word"], name: "index_tokens_on_word"
  end

  create_table "tweets", id: :serial, force: :cascade do |t|
    t.integer "token_id"
    t.text "text", null: false
    t.string "url", null: false
    t.string "username"
    t.string "lang"
    t.string "location"
    t.string "place"
    t.text "geo", array: true
    t.text "bag_of_words", default: [], array: true
    t.text "bag_of_hashtags", default: [], array: true
    t.text "bag_of_mentions", default: [], array: true
    t.text "bag_of_links", default: [], array: true
    t.text "tf_idfs", default: [], array: true
    t.string "rate"
    t.boolean "reply", default: false
    t.boolean "retweet", default: false
    t.string "rate_svm"
    t.boolean "svm_rate_validate"
    t.datetime "publish_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "rate_open"
    t.string "uuid"
    t.text "rate_open_by"
    t.index ["token_id"], name: "index_tweets_on_token_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "role"
    t.string "twitter_id"
    t.string "username"
    t.string "avatar"
    t.string "token"
    t.string "secret"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "company_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "words", force: :cascade do |t|
    t.string "name"
    t.boolean "banned", default: false
    t.integer "df", default: 0, null: false
    t.bigint "token_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["token_id"], name: "index_words_on_token_id"
  end

  add_foreign_key "hashtags", "tokens"
  add_foreign_key "languages", "tokens"
  add_foreign_key "links", "tokens"
  add_foreign_key "locations", "tokens"
  add_foreign_key "mentions", "tokens"
  add_foreign_key "newsletters", "tokens"
  add_foreign_key "profiles", "tokens"
  add_foreign_key "statistics", "tokens"
  add_foreign_key "tokens", "categories"
  add_foreign_key "words", "tokens"
end
