class CreateApplicants < ActiveRecord::Migration[8.1]
  def change
    create_table :applicants do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :national_id
      t.string :phone_number
      t.string :password_digest

      t.timestamps
    end
    add_index :applicants, :email
    add_index :applicants, :national_id
  end
end
