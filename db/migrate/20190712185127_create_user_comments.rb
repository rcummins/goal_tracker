class CreateUserComments < ActiveRecord::Migration[5.2]
  def change
    create_table :user_comments do |t|
      t.integer :subject_id, null: false
      t.integer :author_id, null: false
      t.text :comment_text, null: false

      t.timestamps
    end

    add_index :user_comments, :subject_id
    add_foreign_key :user_comments, :users, column: :subject_id
    add_foreign_key :user_comments, :users, column: :author_id
  end
end
