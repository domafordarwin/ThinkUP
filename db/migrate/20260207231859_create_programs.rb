class CreatePrograms < ActiveRecord::Migration[8.1]
  def change
    create_table :programs do |t|
      t.string :name, null: false
      t.text :description
      t.integer :target_grade_min, null: false
      t.integer :target_grade_max, null: false
      t.date :starts_on, null: false
      t.date :ends_on, null: false

      t.timestamps
    end
  end
end
