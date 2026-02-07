class CreateSchoolEnrollments < ActiveRecord::Migration[8.1]
  def change
    create_table :school_enrollments do |t|
      t.references :school, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :role_in_school, default: 0, null: false

      t.timestamps
    end

    add_index :school_enrollments, [:school_id, :user_id], unique: true
  end
end
