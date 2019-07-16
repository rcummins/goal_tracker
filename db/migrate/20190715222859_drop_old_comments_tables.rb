class DropOldCommentsTables < ActiveRecord::Migration[5.2]
  def up
    drop_table :user_comments
    drop_table :goal_comments
  end

  def down
    create_table :user_comments do |t|
      t.integer :subject_id, null: false
      t.integer :author_id, null: false
      t.text :comment_text, null: false

      t.timestamps
    end

    add_index :user_comments, :subject_id
    add_foreign_key :user_comments, :users, column: :subject_id
    add_foreign_key :user_comments, :users, column: :author_id

    create_table :goal_comments do |t|
      t.integer :subject_id, null: false
      t.integer :author_id, null: false
      t.text :comment_text, null: false

      t.timestamps
    end

    add_index :goal_comments, :subject_id
    add_foreign_key :goal_comments, :goals, column: :subject_id
    add_foreign_key :goal_comments, :users, column: :author_id
  end
end
