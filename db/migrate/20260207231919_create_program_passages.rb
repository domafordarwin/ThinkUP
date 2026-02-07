class CreateProgramPassages < ActiveRecord::Migration[8.1]
  def change
    create_table :program_passages do |t|
      t.references :program, null: false, foreign_key: true
      t.references :passage, null: false, foreign_key: true
      t.integer :position, default: 0, null: false

      t.timestamps
    end

    add_index :program_passages, [:program_id, :passage_id], unique: true
  end
end
