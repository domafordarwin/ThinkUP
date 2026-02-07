class CreateLearningSessions < ActiveRecord::Migration[8.1]
  def change
    create_table :learning_sessions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :passage, null: false, foreign_key: true
      t.integer :status, default: 0, null: false
      t.integer :current_bloom_stage, default: 1, null: false

      t.timestamps
    end

    add_index :learning_sessions, [:user_id, :status]
  end
end
