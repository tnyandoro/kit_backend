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

ActiveRecord::Schema[8.1].define(version: 2026_06_13_205355) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "administrators", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.string "password_digest"
    t.string "role"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_administrators_on_email"
  end

  create_table "applicants", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.string "first_name"
    t.string "last_name"
    t.string "national_id"
    t.string "password_digest"
    t.string "phone_number"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_applicants_on_email"
    t.index ["national_id"], name: "index_applicants_on_national_id"
  end

  create_table "individual_applications", force: :cascade do |t|
    t.text "additional_information"
    t.datetime "created_at", null: false
    t.date "date_of_birth"
    t.text "disability_details"
    t.string "duration"
    t.string "email"
    t.string "employer"
    t.string "full_name"
    t.string "gender"
    t.string "has_disability"
    t.text "home_address"
    t.string "id_passport_number"
    t.string "institution"
    t.string "last_name"
    t.string "mode_of_study"
    t.string "nationality"
    t.string "overall_result"
    t.string "phone"
    t.string "position"
    t.string "program"
    t.string "qualification"
    t.string "race"
    t.string "status"
    t.datetime "updated_at", null: false
    t.string "year_completed"
  end

  create_table "organization_applications", force: :cascade do |t|
    t.text "additional_information"
    t.string "city_province_country"
    t.string "contact_person_full_name"
    t.string "contact_person_position"
    t.datetime "created_at", null: false
    t.string "email"
    t.string "gps_coordinates"
    t.string "industry_sector"
    t.string "institution_name"
    t.string "institution_type"
    t.integer "number_of_trainees"
    t.string "phone"
    t.text "physical_address"
    t.string "program"
    t.string "registration_number"
    t.string "status"
    t.string "tax_number"
    t.datetime "updated_at", null: false
  end

  create_table "programs", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "duration"
    t.string "faculty"
    t.string "level"
    t.string "name"
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_programs_on_name"
  end
end
