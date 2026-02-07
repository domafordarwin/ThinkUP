class CreateSchools < ActiveRecord::Migration[8.1]
  def change
    create_table :schools do |t|
      t.string :name, null: false
      t.string :region

      t.timestamps
    end

    add_index :schools, :name
  end
end
