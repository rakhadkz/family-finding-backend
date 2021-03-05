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

ActiveRecord::Schema.define(version: 2021_03_03_194400) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
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

  create_table "alerts", force: :cascade do |t|
    t.bigint "child_id"
    t.bigint "contact_id"
    t.date "date"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["child_id"], name: "index_alerts_on_child_id"
    t.index ["contact_id"], name: "index_alerts_on_contact_id"
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

  create_table "child_contact_attachments", force: :cascade do |t|
    t.bigint "child_contact_id"
    t.bigint "attachment_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["attachment_id"], name: "index_child_contact_attachments_on_attachment_id"
    t.index ["child_contact_id"], name: "index_child_contact_attachments_on_child_contact_id"
  end

  create_table "child_contact_comments", force: :cascade do |t|
    t.bigint "child_contact_id"
    t.bigint "comment_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["child_contact_id"], name: "index_child_contact_comments_on_child_contact_id"
    t.index ["comment_id"], name: "index_child_contact_comments_on_comment_id"
  end

  create_table "child_contacts", force: :cascade do |t|
    t.bigint "child_id"
    t.bigint "contact_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "relationship"
    t.bigint "parent_id"
    t.integer "family_fit_score", default: 0
    t.boolean "potential_match", default: false
    t.boolean "is_confirmed", default: false
    t.boolean "is_placed", default: false
    t.boolean "is_disqualified", default: false
    t.text "disqualify_reason"
    t.datetime "placed_date"
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
    t.string "system_status"
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
    t.text "html_body"
    t.index ["child_id"], name: "index_comments_on_child_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "communication_templates", force: :cascade do |t|
    t.string "name"
    t.text "content"
    t.string "template_type"
    t.bigint "organization_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_communication_templates_on_organization_id"
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

  create_table "family_search_attachments", force: :cascade do |t|
    t.bigint "family_search_id"
    t.bigint "attachment_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["attachment_id"], name: "index_family_search_attachments_on_attachment_id"
    t.index ["family_search_id"], name: "index_family_search_attachments_on_family_search_id"
  end

  create_table "family_search_connections", force: :cascade do |t|
    t.bigint "family_search_id"
    t.bigint "child_contact_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["child_contact_id"], name: "index_family_search_connections_on_child_contact_id"
    t.index ["family_search_id", "child_contact_id"], name: "family_search_connections_unique", unique: true
    t.index ["family_search_id"], name: "index_family_search_connections_on_family_search_id"
  end

  create_table "family_searches", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "search_vector_id"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "child_id"
    t.text "blocks"
    t.index ["child_id"], name: "index_family_searches_on_child_id"
    t.index ["search_vector_id"], name: "index_family_searches_on_search_vector_id"
    t.index ["user_id"], name: "index_family_searches_on_user_id"
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

  create_table "good_jobs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "queue_name"
    t.integer "priority"
    t.jsonb "serialized_params"
    t.datetime "scheduled_at"
    t.datetime "performed_at"
    t.datetime "finished_at"
    t.text "error"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["queue_name", "scheduled_at"], name: "index_good_jobs_on_queue_name_and_scheduled_at", where: "(finished_at IS NULL)"
    t.index ["scheduled_at"], name: "index_good_jobs_on_scheduled_at", where: "(finished_at IS NULL)"
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
    t.bigint "organization_id"
    t.index ["organization_id"], name: "index_search_vectors_on_organization_id"
  end

  create_table "sendgrid_domains", force: :cascade do |t|
    t.bigint "organization_id"
    t.integer "domain_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["organization_id"], name: "index_sendgrid_domains_on_organization_id"
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

  create_table "templates_sents", force: :cascade do |t|
    t.bigint "communication_template_id"
    t.string "content"
    t.string "opened"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "sid"
    t.bigint "child_contact_id"
    t.index ["child_contact_id"], name: "index_templates_sents_on_child_contact_id"
    t.index ["communication_template_id"], name: "index_templates_sents_on_communication_template_id"
  end

  create_table "twilio_phone_numbers", force: :cascade do |t|
    t.bigint "organization_id"
    t.string "phone"
    t.string "friendly_name"
    t.string "phone_sid"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["organization_id"], name: "index_twilio_phone_numbers_on_organization_id"
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
  add_foreign_key "alerts", "children"
  add_foreign_key "alerts", "contacts"
  add_foreign_key "attachments", "users"
  add_foreign_key "child_contact_attachments", "attachments"
  add_foreign_key "child_contact_attachments", "child_contacts"
  add_foreign_key "child_contact_comments", "child_contacts"
  add_foreign_key "child_contact_comments", "comments"
  add_foreign_key "comments", "children"
  add_foreign_key "comments", "users"
  add_foreign_key "communication_templates", "organizations"
  add_foreign_key "family_search_attachments", "attachments"
  add_foreign_key "family_search_attachments", "family_searches"
  add_foreign_key "family_search_connections", "child_contacts"
  add_foreign_key "family_search_connections", "family_searches"
  add_foreign_key "family_searches", "children"
  add_foreign_key "family_searches", "search_vectors"
  add_foreign_key "family_searches", "users"
  add_foreign_key "findings", "children"
  add_foreign_key "findings", "search_vectors"
  add_foreign_key "findings", "users"
  add_foreign_key "search_vectors", "organizations"
  add_foreign_key "sendgrid_domains", "organizations"
  add_foreign_key "siblingships", "children"
  add_foreign_key "siblingships", "children", column: "sibling_id"
  add_foreign_key "templates_sents", "child_contacts"
  add_foreign_key "templates_sents", "communication_templates"
  add_foreign_key "twilio_phone_numbers", "organizations"
  add_foreign_key "user_children", "children"
  add_foreign_key "user_children", "users"
  add_foreign_key "user_organizations", "organizations"
  add_foreign_key "user_organizations", "users"
  add_foreign_key "users", "organizations"
end
