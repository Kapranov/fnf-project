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

ActiveRecord::Schema.define(version: 20151124114035) do

  create_table "activities", force: :cascade do |t|
    t.integer  "trackable_id",   limit: 4
    t.string   "trackable_type", limit: 255
    t.integer  "owner_id",       limit: 4
    t.string   "owner_type",     limit: 255
    t.string   "key",            limit: 255
    t.text     "parameters",     limit: 65535
    t.integer  "recipient_id",   limit: 4
    t.string   "recipient_type", limit: 255
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type", using: :btree
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type", using: :btree
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree

  create_table "categories", force: :cascade do |t|
    t.integer  "parent_id",        limit: 4
    t.string   "image",            limit: 255
    t.integer  "lft",              limit: 4,                           null: false
    t.integer  "rgt",              limit: 4,                           null: false
    t.integer  "depth",            limit: 4,     default: 0,           null: false
    t.integer  "children_count",   limit: 4,     default: 0,           null: false
    t.string   "name",             limit: 255
    t.text     "description",      limit: 65535
    t.string   "meta_title",       limit: 255
    t.string   "meta_keywords",    limit: 255
    t.text     "meta_description", limit: 65535
    t.string   "status",           limit: 255,   default: "published"
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
  end

  add_index "categories", ["name"], name: "index_categories_on_name", using: :btree

  create_table "category_translations", force: :cascade do |t|
    t.integer  "category_id",      limit: 4,     null: false
    t.string   "locale",           limit: 255,   null: false
    t.string   "name",             limit: 255
    t.text     "description",      limit: 65535
    t.string   "meta_title",       limit: 255
    t.string   "meta_keywords",    limit: 255
    t.text     "meta_description", limit: 65535
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "category_translations", ["category_id"], name: "index_category_translations_on_category_id", using: :btree
  add_index "category_translations", ["locale"], name: "index_category_translations_on_locale", using: :btree

  create_table "companies", force: :cascade do |t|
    t.integer  "user_id",            limit: 4
    t.string   "logo",               limit: 255
    t.string   "name",               limit: 255
    t.text     "description",        limit: 65535
    t.string   "business_entity",    limit: 255
    t.string   "vatcode",            limit: 255
    t.string   "company_id_number",  limit: 255
    t.string   "cea",                limit: 255
    t.date     "registration_date"
    t.string   "juridical_country",  limit: 255
    t.string   "juridical_province", limit: 255
    t.string   "juridical_city",     limit: 255
    t.string   "juridical_address",  limit: 255
    t.string   "country",            limit: 255
    t.string   "province",           limit: 255
    t.string   "city",               limit: 255
    t.string   "address",            limit: 255
    t.string   "website",            limit: 255
    t.string   "mobile",             limit: 255
    t.string   "phone",              limit: 255
    t.string   "fax",                limit: 255
    t.string   "email",              limit: 255
    t.string   "meta_title",         limit: 255
    t.string   "meta_keywords",      limit: 255
    t.string   "meta_description",   limit: 255
    t.integer  "state",              limit: 4
    t.string   "type_company",       limit: 255
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "companies", ["user_id"], name: "index_companies_on_user_id", using: :btree

  create_table "company_translations", force: :cascade do |t|
    t.integer  "company_id",       limit: 4,     null: false
    t.string   "locale",           limit: 255,   null: false
    t.string   "name",             limit: 255
    t.text     "description",      limit: 65535
    t.string   "address",          limit: 255
    t.string   "meta_title",       limit: 255
    t.string   "meta_keywords",    limit: 255
    t.string   "meta_description", limit: 255
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "company_translations", ["company_id"], name: "index_company_translations_on_company_id", using: :btree
  add_index "company_translations", ["locale"], name: "index_company_translations_on_locale", using: :btree

  create_table "follows", force: :cascade do |t|
    t.string   "follower_type",   limit: 255
    t.integer  "follower_id",     limit: 4
    t.string   "followable_type", limit: 255
    t.integer  "followable_id",   limit: 4
    t.datetime "created_at"
  end

  add_index "follows", ["followable_id", "followable_type"], name: "fk_followables", using: :btree
  add_index "follows", ["follower_id", "follower_type"], name: "fk_follows", using: :btree

  create_table "likes", force: :cascade do |t|
    t.string   "liker_type",    limit: 255
    t.integer  "liker_id",      limit: 4
    t.string   "likeable_type", limit: 255
    t.integer  "likeable_id",   limit: 4
    t.datetime "created_at"
  end

  add_index "likes", ["likeable_id", "likeable_type"], name: "fk_likeables", using: :btree
  add_index "likes", ["liker_id", "liker_type"], name: "fk_likes", using: :btree

  create_table "mentions", force: :cascade do |t|
    t.string   "mentioner_type",   limit: 255
    t.integer  "mentioner_id",     limit: 4
    t.string   "mentionable_type", limit: 255
    t.integer  "mentionable_id",   limit: 4
    t.datetime "created_at"
  end

  add_index "mentions", ["mentionable_id", "mentionable_type"], name: "fk_mentionables", using: :btree
  add_index "mentions", ["mentioner_id", "mentioner_type"], name: "fk_mentions", using: :btree

  create_table "order_items", force: :cascade do |t|
    t.integer  "order_id",          limit: 4
    t.integer  "ordered_item_id",   limit: 4
    t.string   "ordered_item_type", limit: 255
    t.integer  "quantity",          limit: 4,                           default: 1
    t.decimal  "unit_price",                    precision: 8, scale: 2
    t.decimal  "unit_cost_price",               precision: 8, scale: 2
    t.decimal  "tax_amount",                    precision: 8, scale: 2
    t.decimal  "tax_rate",                      precision: 8, scale: 2
    t.decimal  "weight",                        precision: 8, scale: 3
    t.datetime "created_at",                                                        null: false
    t.datetime "updated_at",                                                        null: false
  end

  add_index "order_items", ["order_id"], name: "index_order_items_on_order_id", using: :btree
  add_index "order_items", ["ordered_item_id", "ordered_item_type"], name: "index_order_items_ordered_item", using: :btree

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id",            limit: 4
    t.string   "token",              limit: 255
    t.string   "status",             limit: 255
    t.datetime "received_at"
    t.datetime "accepted_at"
    t.datetime "shipped_at"
    t.string   "consignment_number", limit: 255
    t.datetime "rejected_at"
    t.integer  "rejected_by",        limit: 4
    t.string   "ip_address",         limit: 255
    t.text     "notes",              limit: 65535
    t.boolean  "exported",                         default: false
    t.string   "invoice_number",     limit: 255
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
  end

  add_index "orders", ["received_at"], name: "index_orders_on_received_at", using: :btree
  add_index "orders", ["token"], name: "index_orders_on_token", using: :btree

  create_table "product_attachments", force: :cascade do |t|
    t.integer  "product_id",          limit: 4
    t.string   "attach_id",           limit: 255
    t.string   "attach_filename",     limit: 255
    t.integer  "attach_size",         limit: 4
    t.string   "attach_content_type", limit: 255
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "product_attachments", ["product_id"], name: "index_attachments_on_product_id", using: :btree

  create_table "product_attributes", force: :cascade do |t|
    t.integer  "product_id", limit: 4
    t.string   "key",        limit: 255
    t.string   "value",      limit: 255
    t.integer  "position",   limit: 4,   default: 1
    t.boolean  "searchable",             default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "public",                 default: true
  end

  add_index "product_attributes", ["key"], name: "index_product_attributes_on_key", using: :btree
  add_index "product_attributes", ["position"], name: "index_product_attributes_on_position", using: :btree
  add_index "product_attributes", ["product_id"], name: "index_product_attributes_on_product_id", using: :btree

  create_table "product_images", force: :cascade do |t|
    t.integer  "product_id", limit: 4
    t.string   "image",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "products", force: :cascade do |t|
    t.integer  "user_id",             limit: 4
    t.integer  "category_id",         limit: 4
    t.integer  "company_id",          limit: 4
    t.integer  "trademark_id",        limit: 4
    t.string   "name",                limit: 255
    t.text     "description",         limit: 65535
    t.string   "ean13",               limit: 255
    t.decimal  "price",                             precision: 12, scale: 3
    t.string   "reference",           limit: 255
    t.string   "supplier_reference",  limit: 255
    t.string   "width",               limit: 255
    t.string   "height",              limit: 255
    t.string   "depth",               limit: 255
    t.decimal  "weight",                            precision: 12, scale: 3
    t.string   "available_for_order", limit: 255
    t.string   "available_date",      limit: 255
    t.string   "show_price",          limit: 255
    t.integer  "visibility",          limit: 1
    t.string   "status",              limit: 255,                            default: "published"
    t.string   "meta_title",          limit: 255
    t.string   "meta_keywords",       limit: 255
    t.text     "meta_description",    limit: 65535
    t.datetime "created_at",                                                                       null: false
    t.datetime "updated_at",                                                                       null: false
  end

  add_index "products", ["user_id"], name: "index_products_on_user_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name",        limit: 255,   null: false
    t.string   "title",       limit: 255,   null: false
    t.text     "description", limit: 65535, null: false
    t.text     "the_role",    limit: 65535, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trademarks", force: :cascade do |t|
    t.integer  "user_id",           limit: 4
    t.integer  "company_id",        limit: 4
    t.string   "logo",              limit: 255
    t.string   "name",              limit: 255
    t.text     "description",       limit: 65535
    t.string   "website",           limit: 255
    t.date     "registration_date"
    t.string   "meta_title",        limit: 255
    t.string   "meta_keywords",     limit: 255
    t.text     "meta_description",  limit: 65535
    t.string   "status",            limit: 255,   default: "published"
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
  end

  add_index "trademarks", ["company_id"], name: "index_trademarks_on_company_id", using: :btree
  add_index "trademarks", ["user_id"], name: "index_trademarks_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255,                      null: false
    t.string   "encrypted_password",     limit: 255,   default: "",       null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,     default: 0,        null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.integer  "failed_attempts",        limit: 4,     default: 0
    t.string   "unlock_token",           limit: 255
    t.string   "locked_at",              limit: 255
    t.string   "first_name",             limit: 255
    t.string   "last_name",              limit: 255
    t.string   "post",                   limit: 255
    t.string   "province",               limit: 255
    t.string   "city",                   limit: 255
    t.integer  "role_id",                limit: 4
    t.string   "status",                 limit: 255,   default: "active"
    t.text     "note",                   limit: 65535
    t.text     "about",                  limit: 65535
    t.string   "avatar",                 limit: 255
    t.string   "invitation_token",       limit: 255
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit",       limit: 4
    t.integer  "invited_by_id",          limit: 4
    t.string   "invited_by_type",        limit: 255
    t.integer  "invitations_count",      limit: 4,     default: 0
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
  add_index "users", ["invitations_count"], name: "index_users_on_invitations_count", using: :btree
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
