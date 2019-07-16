class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.integer :commentable_id, null: false
      t.string :commentable_type, null: false
      t.integer :author_id, null: false
      t.text :comment_text, null: false

      t.timestamps
    end

    add_index :comments, [:commentable_type, :commentable_id]
    add_foreign_key :comments, :users, column: :author_id
  end
end
