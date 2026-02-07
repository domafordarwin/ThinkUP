class CreateStudentQuestions < ActiveRecord::Migration[8.1]
  def change
    create_table :student_questions do |t|
      t.references :learning_session, null: false, foreign_key: true
      t.text :content, null: false
      t.integer :bloom_level, default: 0, null: false

      t.timestamps
    end

    add_index :student_questions, :bloom_level
  end
end
