class CreateGoals < ActiveRecord::Migration[5.2]
  def change
    create_table :goals do |t|
      t.integer :user_id, null: false
      t.string :title, null: false
      t.text :description
      t.datetime :due_date
      t.string :privacy, null: false
      t.string :completion, null: false, default: 'Not completed'

      t.timestamps
    end

    add_index :goals, [:user_id, :privacy, :completion]
    add_index :goals, [:user_id, :completion]
    add_foreign_key :goals, :users
  end
end
