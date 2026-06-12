class CreatePrograms < ActiveRecord::Migration[8.1]
  def change
    create_table :programs do |t|
      t.string :faculty
      t.string :name
      t.string :level
      t.string :duration

      t.timestamps
    end
    add_index :programs, :name
  end
end
