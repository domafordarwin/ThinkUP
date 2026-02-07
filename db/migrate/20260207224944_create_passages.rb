class CreatePassages < ActiveRecord::Migration[8.1]
  def change
    create_table :passages do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.integer :genre, default: 0, null: false
      t.integer :difficulty, default: 1, null: false
      t.integer :min_grade, null: false
      t.integer :max_grade, null: false
      t.string :subject_tags

      t.timestamps
    end

    add_index :passages, :genre
    add_index :passages, :difficulty
    add_index :passages, [:min_grade, :max_grade]
  end
end
