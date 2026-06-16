class CreateAdministrators < ActiveRecord::Migration[8.1]
  def change
    create_table :administrators do |t|
      t.string :email
      t.string :password_digest
      t.string :role, default: "staff"

      t.timestamps
    end

    add_index :administrators, :email, unique: true
  end
end