class AddRoleAndProfileToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :role, :integer, default: 0, null: false
    add_column :users, :grade_level, :integer
    add_column :users, :thinking_level, :integer, default: 1, null: false
    add_column :users, :name, :string, null: false, default: ""

    add_index :users, :role
    add_index :users, :grade_level
  end
end
