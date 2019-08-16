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

ActiveRecord::Schema.define(version: 2019_08_15_074050) do

  create_table "access_permits", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "use_case_name"
    t.string "use_case_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "access_permits_user_profiles", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "access_permit_id", null: false
    t.bigint "user_profile_id", null: false
    t.index ["access_permit_id"], name: "index_access_permits_user_profiles_on_access_permit_id"
    t.index ["user_profile_id"], name: "index_access_permits_user_profiles_on_user_profile_id"
  end

  create_table "funds_destinations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.bigint "funds_resolution_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["funds_resolution_id"], name: "index_funds_destinations_on_funds_resolution_id"
  end

  create_table "funds_resolutions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "number"
    t.date "date"
    t.bigint "resolution_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["resolution_type_id"], name: "index_funds_resolutions_on_resolution_type_id"
  end

  create_table "order_detail_attribute_values", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "value"
    t.bigint "order_detail_attribute_id"
    t.bigint "order_detail_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_detail_attribute_id"], name: "index_order_detail_attribute_values_on_order_detail_attribute_id"
    t.index ["order_detail_id"], name: "index_order_detail_attribute_values_on_order_detail_id"
  end

  create_table "order_detail_attributes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "attribute_name"
    t.string "attribute_type"
    t.datetime "is_disabled"
    t.bigint "order_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_type_id"], name: "index_order_detail_attributes_on_order_type_id"
  end

  create_table "order_details", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "description_detail"
    t.bigint "order_id"
    t.bigint "subsection_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_details_on_order_id"
    t.index ["subsection_id"], name: "index_order_details_on_subsection_id"
  end

  create_table "order_status_histories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "date_change_status_order"
    t.string "reason_change_status_order"
    t.bigint "order_status_id"
    t.bigint "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_status_histories_on_order_id"
    t.index ["order_status_id"], name: "index_order_status_histories_on_order_status_id"
  end

  create_table "order_statuses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "order_status_name"
    t.text "order_status_description"
    t.boolean "allow_cancel_order"
    t.datetime "is_disabled"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_type_attribute_values", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "value"
    t.bigint "order_type_attribute_id"
    t.bigint "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_type_attribute_values_on_order_id"
    t.index ["order_type_attribute_id"], name: "index_order_type_attribute_values_on_order_type_attribute_id"
  end

  create_table "order_type_attributes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "attribute_name"
    t.string "attribute_type"
    t.datetime "is_disabled"
    t.bigint "order_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_type_id"], name: "index_order_type_attributes_on_order_type_id"
  end

  create_table "order_types", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name_type_order"
    t.text "description_type_order"
    t.datetime "is_disabled"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "order_date"
    t.text "reason_order"
    t.text "description_order"
    t.bigint "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_orders_on_project_id"
  end

  create_table "project_funds_details", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.float "funds_amount"
    t.integer "year"
    t.bigint "subsection_id"
    t.bigint "funds_destination_id"
    t.bigint "subsection_shift_id"
    t.bigint "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["funds_destination_id"], name: "index_project_funds_details_on_funds_destination_id"
    t.index ["project_id"], name: "index_project_funds_details_on_project_id"
    t.index ["subsection_id"], name: "index_project_funds_details_on_subsection_id"
    t.index ["subsection_shift_id"], name: "index_project_funds_details_on_subsection_shift_id"
  end

  create_table "project_statuses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "is_disabled"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "project_types", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "purpose"
    t.string "function"
    t.string "program"
    t.string "activity"
    t.string "financing"
    t.datetime "is_disabled"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "projects", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "project_code"
    t.string "project_name"
    t.string "project_description"
    t.datetime "start_date"
    t.datetime "ending_date"
    t.string "technological_scientific_unit"
    t.string "project_program"
    t.string "activity_type"
    t.bigint "project_status_id"
    t.bigint "project_type_id"
    t.bigint "director_id"
    t.bigint "codirector_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["codirector_id"], name: "index_projects_on_codirector_id"
    t.index ["director_id"], name: "index_projects_on_director_id"
    t.index ["project_status_id"], name: "index_projects_on_project_status_id"
    t.index ["project_type_id"], name: "index_projects_on_project_type_id"
  end

  create_table "resolution_types", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "is_disabled"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subsection_shift_status_histories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "date"
    t.bigint "subsection_shift_status_id"
    t.bigint "subsection_shift_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subsection_shift_id"], name: "subsection_shift_fk_index"
    t.index ["subsection_shift_status_id"], name: "subsection_shift_status_fk_index"
  end

  create_table "subsection_shift_statuses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "is_disabled"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subsection_shifts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "requested_date"
    t.text "requested_cause"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subsections", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "is_disabled"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "university_positions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.float "per_travel_payment"
    t.float "per_lunch_payment"
    t.datetime "is_disabled"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_profiles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "is_disabled"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "user_name"
    t.string "password"
    t.integer "file_number"
    t.string "last_name"
    t.string "first_name"
    t.string "email"
    t.string "telephone"
    t.integer "cuil"
    t.datetime "is_disabled"
    t.bigint "university_position_id"
    t.bigint "user_profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["university_position_id"], name: "index_users_on_university_position_id"
    t.index ["user_profile_id"], name: "index_users_on_user_profile_id"
  end

  create_table "value_histories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "date"
    t.float "amount"
    t.text "description"
    t.bigint "order_detail_id"
    t.bigint "value_status_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_detail_id"], name: "index_value_histories_on_order_detail_id"
    t.index ["value_status_id"], name: "index_value_histories_on_value_status_id"
  end

  create_table "value_statuses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "value_status_name"
    t.datetime "is_disabled"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "funds_destinations", "funds_resolutions"
  add_foreign_key "funds_resolutions", "resolution_types"
  add_foreign_key "order_detail_attribute_values", "order_detail_attributes"
  add_foreign_key "order_detail_attribute_values", "order_details"
  add_foreign_key "order_detail_attributes", "order_types"
  add_foreign_key "order_details", "orders"
  add_foreign_key "order_details", "subsections"
  add_foreign_key "order_status_histories", "order_statuses"
  add_foreign_key "order_status_histories", "orders"
  add_foreign_key "order_type_attribute_values", "order_type_attributes"
  add_foreign_key "order_type_attribute_values", "orders"
  add_foreign_key "order_type_attributes", "order_types"
  add_foreign_key "orders", "projects"
  add_foreign_key "project_funds_details", "funds_destinations"
  add_foreign_key "project_funds_details", "projects"
  add_foreign_key "project_funds_details", "subsection_shifts"
  add_foreign_key "project_funds_details", "subsections"
  add_foreign_key "projects", "project_statuses"
  add_foreign_key "projects", "project_types"
  add_foreign_key "projects", "users", column: "codirector_id"
  add_foreign_key "projects", "users", column: "director_id"
  add_foreign_key "subsection_shift_status_histories", "subsection_shift_statuses"
  add_foreign_key "subsection_shift_status_histories", "subsection_shifts"
  add_foreign_key "users", "university_positions"
  add_foreign_key "users", "user_profiles"
  add_foreign_key "value_histories", "order_details"
  add_foreign_key "value_histories", "value_statuses"
end
