# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_12_30_180846) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_items", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.bigint "user_id"
    t.bigint "child_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "date_removed"
    t.bigint "organization_id"
    t.bigint "related_user_id"
    t.string "action_type"
    t.index ["child_id"], name: "index_action_items_on_child_id"
    t.index ["organization_id"], name: "index_action_items_on_organization_id"
    t.index ["user_id"], name: "index_action_items_on_user_id"
  end

  create_table "attachments", force: :cascade do |t|
    t.string "file_name"
    t.string "file_type"
    t.string "file_url"
    t.integer "file_size"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "file_id"
    t.string "file_format"
    t.index ["user_id"], name: "index_attachments_on_user_id"
  end

  create_table "child_attachments", force: :cascade do |t|
    t.bigint "child_id"
    t.bigint "attachment_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["attachment_id"], name: "index_child_attachments_on_attachment_id"
    t.index ["child_id", "attachment_id"], name: "index_child_attachments_on_child_id_and_attachment_id", unique: true
    t.index ["child_id"], name: "index_child_attachments_on_child_id"
  end

  create_table "child_contacts", force: :cascade do |t|
    t.bigint "child_id"
    t.bigint "contact_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "relationship"
    t.bigint "parent_id"
    t.index ["child_id", "contact_id"], name: "index_child_contacts_on_child_id_and_contact_id", unique: true
    t.index ["child_id"], name: "index_child_contacts_on_child_id"
    t.index ["contact_id"], name: "index_child_contacts_on_contact_id"
  end

  create_table "child_tree_contacts", force: :cascade do |t|
    t.bigint "child_id"
    t.bigint "contact_id"
    t.string "relationship"
    t.bigint "parent_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["child_id"], name: "index_child_tree_contacts_on_child_id"
    t.index ["contact_id"], name: "index_child_tree_contacts_on_contact_id"
  end

  create_table "children", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "permanency_goal"
    t.datetime "birthday"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "continuous_search", default: "Yes"
    t.string "race"
    t.string "gender"
    t.string "permanency_status"
  end

  create_table "comment_attachments", force: :cascade do |t|
    t.bigint "comment_id"
    t.bigint "attachment_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["attachment_id"], name: "index_comment_attachments_on_attachment_id"
    t.index ["comment_id", "attachment_id"], name: "index_comment_attachments_on_comment_id_and_attachment_id", unique: true
    t.index ["comment_id"], name: "index_comment_attachments_on_comment_id"
  end

  create_table "comments", force: :cascade do |t|
    t.bigint "user_id"
    t.string "title"
    t.text "body"
    t.bigint "in_reply_to"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "child_id"
    t.integer "mentions", default: [], array: true
    t.index ["child_id"], name: "index_comments_on_child_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.datetime "birthday"
    t.string "address"
    t.string "address_2"
    t.string "city"
    t.string "state"
    t.string "email"
    t.string "phone"
    t.string "zip"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "parent_id"
    t.string "relationship"
  end

  create_table "finding_attachments", force: :cascade do |t|
    t.bigint "finding_id"
    t.bigint "attachment_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["attachment_id"], name: "index_finding_attachments_on_attachment_id"
    t.index ["finding_id", "attachment_id"], name: "index_finding_attachments_on_finding_id_and_attachment_id", unique: true
    t.index ["finding_id"], name: "index_finding_attachments_on_finding_id"
  end

  create_table "findings", force: :cascade do |t|
    t.bigint "child_id"
    t.bigint "search_vector_id"
    t.bigint "user_id"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["child_id"], name: "index_findings_on_child_id"
    t.index ["search_vector_id"], name: "index_findings_on_search_vector_id"
    t.index ["user_id"], name: "index_findings_on_user_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.text "address"
    t.string "phone"
    t.text "logo"
    t.text "website"
    t.string "state"
    t.string "zip"
    t.string "city"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "search_vectors", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.boolean "in_continuous_search"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "siblingships", force: :cascade do |t|
    t.bigint "child_id", null: false
    t.bigint "sibling_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["child_id", "sibling_id"], name: "index_siblingships_on_child_id_and_sibling_id", unique: true
    t.index ["child_id"], name: "index_siblingships_on_child_id"
    t.index ["sibling_id", "child_id"], name: "index_siblingships_on_sibling_id_and_child_id", unique: true
    t.index ["sibling_id"], name: "index_siblingships_on_sibling_id"
  end

  create_table "user_children", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "child_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "date_approved"
    t.datetime "date_denied"
    t.index ["child_id"], name: "index_user_children_on_child_id"
    t.index ["user_id"], name: "index_user_children_on_user_id"
  end

  create_table "user_organizations", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "organization_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "role", default: "user", null: false
    t.index ["organization_id"], name: "index_user_organizations_on_organization_id"
    t.index ["user_id"], name: "index_user_organizations_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.string "reset_sms_token"
    t.datetime "reset_sms_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "first_name"
    t.string "last_name"
    t.string "role", default: "user", null: false
    t.text "ava"
    t.text "phone"
    t.bigint "organization_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["organization_id"], name: "index_users_on_organization_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "action_items", "organizations"
  add_foreign_key "attachments", "users"
  add_foreign_key "comments", "children"
  add_foreign_key "comments", "users"
  add_foreign_key "findings", "children"
  add_foreign_key "findings", "search_vectors"
  add_foreign_key "findings", "users"
  add_foreign_key "siblingships", "children"
  add_foreign_key "siblingships", "children", column: "sibling_id"
  add_foreign_key "user_children", "children"
  add_foreign_key "user_children", "users"
  add_foreign_key "user_organizations", "organizations"
  add_foreign_key "user_organizations", "users"
  add_foreign_key "users", "organizations"
end
