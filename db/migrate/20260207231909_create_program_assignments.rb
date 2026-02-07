class CreateProgramAssignments < ActiveRecord::Migration[8.1]
  def change
    create_table :program_assignments do |t|
      t.references :program, null: false, foreign_key: true
      t.references :school, null: false, foreign_key: true

      t.timestamps
    end

    add_index :program_assignments, [:program_id, :school_id], unique: true
  end
end
