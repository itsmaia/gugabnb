# frozen_string_literal: true

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

ActiveRecord::Schema[7.0].define(version: 20_221_208_170_523) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'active_storage_attachments', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'record_type', null: false
    t.bigint 'record_id', null: false
    t.bigint 'blob_id', null: false
    t.datetime 'created_at', null: false
    t.index ['blob_id'], name: 'index_active_storage_attachments_on_blob_id'
    t.index %w[record_type record_id name blob_id], name: 'index_active_storage_attachments_uniqueness',
                                                    unique: true
  end

  create_table 'active_storage_blobs', force: :cascade do |t|
    t.string 'key', null: false
    t.string 'filename', null: false
    t.string 'content_type'
    t.text 'metadata'
    t.string 'service_name', null: false
    t.bigint 'byte_size', null: false
    t.string 'checksum'
    t.datetime 'created_at', null: false
    t.index ['key'], name: 'index_active_storage_blobs_on_key', unique: true
  end

  create_table 'active_storage_variant_records', force: :cascade do |t|
    t.bigint 'blob_id', null: false
    t.string 'variation_digest', null: false
    t.index %w[blob_id variation_digest], name: 'index_active_storage_variant_records_uniqueness', unique: true
  end

  create_table 'beds', force: :cascade do |t|
    t.integer 'bed_size'
    t.integer 'room_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['room_id'], name: 'index_beds_on_room_id'
  end

  create_table 'bookings', force: :cascade do |t|
    t.datetime 'start_date'
    t.datetime 'end_date'
    t.bigint 'listing_id', null: false
    t.bigint 'guest_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'guests'
    t.integer 'status'
    t.string 'checkout_url'
    t.string 'checkout_session_id'
    t.string 'stripe_refund_id'
    t.string 'payment_intent_id'
    t.index ['guest_id'], name: 'index_bookings_on_guest_id'
    t.index ['listing_id'], name: 'index_bookings_on_listing_id'
  end

  create_table 'events', force: :cascade do |t|
    t.string 'source'
    t.text 'request_body'
    t.integer 'status'
    t.string 'event_type'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.text 'error_message'
  end

  create_table 'listings', force: :cascade do |t|
    t.integer 'user_id', null: false
    t.string 'short_description'
    t.string 'long_description'
    t.integer 'status', default: 0
    t.integer 'guests', default: 1
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'city'
    t.string 'state'
    t.string 'postal_code'
    t.string 'country'
    t.string 'lat'
    t.string 'lng'
    t.string 'address_line1'
    t.string 'address_line2'
    t.boolean 'active'
    t.string 'product_id'
    t.integer 'rooms_count'
    t.integer 'reviews_count'
    t.index ['user_id'], name: 'index_listings_on_user_id'
  end

  create_table 'notifications', force: :cascade do |t|
    t.string 'recipient_type', null: false
    t.bigint 'recipient_id', null: false
    t.string 'type', null: false
    t.jsonb 'params'
    t.datetime 'read_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['read_at'], name: 'index_notifications_on_read_at'
    t.index %w[recipient_type recipient_id], name: 'index_notifications_on_recipient'
  end

  create_table 'pay_charges', force: :cascade do |t|
    t.bigint 'customer_id', null: false
    t.bigint 'subscription_id'
    t.string 'processor_id', null: false
    t.integer 'amount', null: false
    t.string 'currency'
    t.integer 'application_fee_amount'
    t.integer 'amount_refunded'
    t.jsonb 'metadata'
    t.jsonb 'data'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[customer_id processor_id], name: 'index_pay_charges_on_customer_id_and_processor_id', unique: true
    t.index ['subscription_id'], name: 'index_pay_charges_on_subscription_id'
  end

  create_table 'pay_customers', force: :cascade do |t|
    t.string 'owner_type'
    t.bigint 'owner_id'
    t.string 'processor', null: false
    t.string 'processor_id'
    t.boolean 'default'
    t.jsonb 'data'
    t.datetime 'deleted_at', precision: nil
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[owner_type owner_id deleted_at default], name: 'pay_customer_owner_index'
    t.index %w[processor processor_id], name: 'index_pay_customers_on_processor_and_processor_id', unique: true
  end

  create_table 'pay_merchants', force: :cascade do |t|
    t.string 'owner_type'
    t.bigint 'owner_id'
    t.string 'processor', null: false
    t.string 'processor_id'
    t.boolean 'default'
    t.jsonb 'data'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[owner_type owner_id processor],
            name: 'index_pay_merchants_on_owner_type_and_owner_id_and_processor'
  end

  create_table 'pay_payment_methods', force: :cascade do |t|
    t.bigint 'customer_id', null: false
    t.string 'processor_id', null: false
    t.boolean 'default'
    t.string 'type'
    t.jsonb 'data'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[customer_id processor_id], name: 'index_pay_payment_methods_on_customer_id_and_processor_id',
                                          unique: true
  end

  create_table 'pay_subscriptions', force: :cascade do |t|
    t.bigint 'customer_id', null: false
    t.string 'name', null: false
    t.string 'processor_id', null: false
    t.string 'processor_plan', null: false
    t.integer 'quantity', default: 1, null: false
    t.string 'status', null: false
    t.datetime 'trial_ends_at', precision: nil
    t.datetime 'ends_at', precision: nil
    t.decimal 'application_fee_percent', precision: 8, scale: 2
    t.jsonb 'metadata'
    t.jsonb 'data'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[customer_id processor_id], name: 'index_pay_subscriptions_on_customer_id_and_processor_id',
                                          unique: true
  end

  create_table 'pay_webhooks', force: :cascade do |t|
    t.string 'processor'
    t.string 'event_type'
    t.jsonb 'event'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'pricings', force: :cascade do |t|
    t.decimal 'value'
    t.decimal 'cleaning_fee'
    t.integer 'status'
    t.bigint 'listing_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['listing_id'], name: 'index_pricings_on_listing_id'
  end

  create_table 'reviews', force: :cascade do |t|
    t.bigint 'listing_id', null: false
    t.bigint 'guest_id', null: false
    t.integer 'stars'
    t.text 'description'
    t.string 'title'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['guest_id'], name: 'index_reviews_on_guest_id'
    t.index ['listing_id'], name: 'index_reviews_on_listing_id'
  end

  create_table 'rooms', force: :cascade do |t|
    t.integer 'listing_id', null: false
    t.integer 'room_type'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['listing_id'], name: 'index_rooms_on_listing_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'first_name'
    t.string 'last_name'
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  create_table 'wishes', force: :cascade do |t|
    t.boolean 'wished'
    t.bigint 'user_id', null: false
    t.bigint 'listing_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['listing_id'], name: 'index_wishes_on_listing_id'
    t.index ['user_id'], name: 'index_wishes_on_user_id'
  end

  add_foreign_key 'active_storage_attachments', 'active_storage_blobs', column: 'blob_id'
  add_foreign_key 'active_storage_variant_records', 'active_storage_blobs', column: 'blob_id'
  add_foreign_key 'beds', 'rooms'
  add_foreign_key 'bookings', 'listings'
  add_foreign_key 'bookings', 'users', column: 'guest_id'
  add_foreign_key 'listings', 'users'
  add_foreign_key 'pay_charges', 'pay_customers', column: 'customer_id'
  add_foreign_key 'pay_charges', 'pay_subscriptions', column: 'subscription_id'
  add_foreign_key 'pay_payment_methods', 'pay_customers', column: 'customer_id'
  add_foreign_key 'pay_subscriptions', 'pay_customers', column: 'customer_id'
  add_foreign_key 'pricings', 'listings'
  add_foreign_key 'reviews', 'listings'
  add_foreign_key 'reviews', 'users', column: 'guest_id'
  add_foreign_key 'rooms', 'listings'
  add_foreign_key 'wishes', 'listings'
  add_foreign_key 'wishes', 'users'
end
