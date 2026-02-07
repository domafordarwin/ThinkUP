class CreateBaseQuestions < ActiveRecord::Migration[8.1]
  def change
    create_table :base_questions do |t|
      t.references :passage, null: false, foreign_key: true
      t.text :content, null: false
      t.integer :bloom_level, default: 0, null: false
      t.integer :position, default: 0, null: false

      t.timestamps
    end

    add_index :base_questions, :bloom_level
  end
end
