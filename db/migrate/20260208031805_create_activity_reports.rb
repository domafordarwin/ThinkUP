class CreateActivityReports < ActiveRecord::Migration[8.1]
  def change
    create_table :activity_reports do |t|
      t.integer :report_type, null: false, default: 0
      t.references :user, null: true, foreign_key: true
      t.references :school, null: true, foreign_key: true
      t.references :generated_by, null: false, foreign_key: { to_table: :users }
      t.json :data, default: {}
      t.date :period_start, null: false
      t.date :period_end, null: false

      t.timestamps
    end
  end
end
