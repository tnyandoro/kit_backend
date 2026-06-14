class CreateOrganizationApplications < ActiveRecord::Migration[8.1]
  def change
    create_table :organization_applications do |t|
      t.string :institution_name
      t.string :institution_type
      t.string :registration_number
      t.string :tax_number
      t.string :industry_sector
      t.text :physical_address
      t.string :city_province_country
      t.string :gps_coordinates
      t.string :contact_person_full_name
      t.string :contact_person_position
      t.string :email
      t.string :phone
      t.string :program
      t.integer :number_of_trainees
      t.text :additional_information
      t.string :status

      t.timestamps
    end
  end
end
