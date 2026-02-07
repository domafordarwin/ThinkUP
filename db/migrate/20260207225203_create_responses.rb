class CreateResponses < ActiveRecord::Migration[8.1]
  def change
    create_table :responses do |t|
      t.references :learning_session, null: false, foreign_key: true
      t.references :base_question, null: false, foreign_key: true
      t.text :content, null: false

      t.timestamps
    end
  end
end
