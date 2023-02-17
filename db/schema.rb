# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_02_16_144742) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "followings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "numeric_id", default: -> { "nextval('followings_id_seq'::regclass)" }, null: false
    t.integer "numeric_follower_id"
    t.integer "numeric_following_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "following_id", null: false
    t.uuid "follower_id", null: false
    t.index ["id"], name: "index_followings_on_id", unique: true
  end

  create_table "posts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "numeric_id", default: -> { "nextval('posts_id_seq'::regclass)" }, null: false
    t.text "title", null: false
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "numeric_user_id"
    t.uuid "user_id", null: false
    t.index ["id"], name: "index_posts_on_id", unique: true
    t.index ["numeric_user_id"], name: "index_posts_on_numeric_user_id"
  end

  create_table "reactions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "numeric_id", default: -> { "nextval('reactions_id_seq'::regclass)" }, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "numeric_post_id"
    t.bigint "numeric_user_id"
    t.uuid "user_id", null: false
    t.uuid "post_id", null: false
    t.index ["id"], name: "index_reactions_on_id", unique: true
    t.index ["numeric_post_id"], name: "index_reactions_on_numeric_post_id"
    t.index ["numeric_user_id"], name: "index_reactions_on_numeric_user_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "numeric_id", default: -> { "nextval('users_id_seq'::regclass)" }, null: false
    t.text "first_name", null: false
    t.text "last_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["id"], name: "index_users_on_id", unique: true
  end

  add_foreign_key "followings", "users", column: "follower_id"
  add_foreign_key "followings", "users", column: "following_id"
  add_foreign_key "posts", "users"
  add_foreign_key "reactions", "posts"
  add_foreign_key "reactions", "users"
end
