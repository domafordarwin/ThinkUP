class CreateAiDialogues < ActiveRecord::Migration[8.1]
  def change
    create_table :ai_dialogues do |t|
      t.references :student_question, null: false, foreign_key: true
      t.integer :role, default: 0, null: false
      t.text :content, null: false
      t.integer :position, default: 0, null: false

      t.timestamps
    end
  end
end
