class CreateSessionSummaries < ActiveRecord::Migration[8.1]
  def change
    create_table :session_summaries do |t|
      t.references :learning_session, null: false, foreign_key: true
      t.text :summary, null: false
      t.json :bloom_distribution, default: {}
      t.json :competency_scores, default: {}
      t.text :highlight_question

      t.timestamps
    end
  end
end
