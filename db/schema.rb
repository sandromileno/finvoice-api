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

ActiveRecord::Schema.define(version: 2021_04_11_221339) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.integer "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "chargebacks", force: :cascade do |t|
    t.string "key", null: false
    t.decimal "amount", precision: 10, scale: 6, null: false
    t.text "reason", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "invoice_id"
    t.index ["invoice_id"], name: "index_chargebacks_on_invoice_id"
    t.index ["key", "invoice_id"], name: "index_chargebacks_on_key_and_invoice_id", unique: true
  end

  create_table "customers", force: :cascade do |t|
    t.string "key", null: false
    t.string "full_name", limit: 50, null: false
    t.string "document", limit: 30, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id", null: false
    t.index ["key"], name: "index_customers_on_key", unique: true
    t.index ["user_id"], name: "index_customers_on_user_id"
  end

  create_table "invoices", force: :cascade do |t|
    t.string "key", null: false
    t.string "external_key", limit: 255, null: false
    t.decimal "amount", precision: 10, scale: 6, null: false
    t.decimal "paid", precision: 10, scale: 6, default: "0.0", null: false
    t.decimal "chargebacked", precision: 10, scale: 6, default: "0.0", null: false
    t.date "due_date", null: false
    t.string "status", limit: 12, null: false
    t.text "scan"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "customer_id"
    t.index ["customer_id"], name: "index_invoices_on_customer_id"
    t.index ["external_key", "customer_id"], name: "index_invoices_on_external_key_and_customer_id", unique: true
    t.index ["key"], name: "index_invoices_on_key", unique: true
  end

  create_table "jwt_denylist", force: :cascade do |t|
    t.string "jti", null: false
    t.datetime "exp", null: false
    t.index ["jti"], name: "index_jwt_denylist_on_jti"
  end

  create_table "payments", force: :cascade do |t|
    t.string "key", null: false
    t.decimal "amount", precision: 10, scale: 6, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "invoice_id"
    t.index ["invoice_id"], name: "index_payments_on_invoice_id"
    t.index ["key", "invoice_id"], name: "index_payments_on_key_and_invoice_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "chargebacks", "invoices"
  add_foreign_key "customers", "users"
  add_foreign_key "invoices", "customers"
  add_foreign_key "payments", "invoices"
end
