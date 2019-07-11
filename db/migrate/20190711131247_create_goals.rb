class CreateGoals < ActiveRecord::Migration[5.2]
  def change
    create_table :goals do |t|
      t.integer :user_id, null: false
      t.string :title, null: false
      t.text :description
      t.datetime :due_date
      t.boolean :is_private, null: false
      t.boolean :completed, null: false, default: false

      t.timestamps
    end

    add_index :goals, [:user_id, :is_private, :completed]
    add_index :goals, [:user_id, :completed]
    add_foreign_key :goals, :users
  end
end
