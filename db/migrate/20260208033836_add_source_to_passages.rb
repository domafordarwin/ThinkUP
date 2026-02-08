class AddSourceToPassages < ActiveRecord::Migration[8.1]
  def change
    add_column :passages, :source, :integer, default: 0, null: false
    add_column :passages, :created_by_id, :integer
    add_index :passages, :source
    add_foreign_key :passages, :users, column: :created_by_id
  end
end
