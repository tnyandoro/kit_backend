class CreateIndividualApplications < ActiveRecord::Migration[8.1]
  def change
    create_table :individual_applications do |t|
      t.string :program
      t.string :mode_of_study
      t.string :full_name
      t.string :last_name
      t.string :id_passport_number
      t.date :date_of_birth
      t.string :gender
      t.string :nationality
      t.string :race
      t.text :home_address
      t.string :phone
      t.string :email
      t.string :has_disability
      t.text :disability_details
      t.string :qualification
      t.string :institution
      t.string :year_completed
      t.string :overall_result
      t.string :employer
      t.string :position
      t.string :duration
      t.text :additional_information
      t.string :status

      t.timestamps
    end
  end
end
