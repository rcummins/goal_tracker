class MoveCommentsDataIntoCommentsTable < ActiveRecord::Migration[5.2]
  def up
    execute(
      "INSERT INTO
        comments (
          commentable_id,
          commentable_type,
          author_id,
          comment_text,
          created_at,
          updated_at)
      SELECT
        subject_id,
        'User',
        author_id,
        comment_text,
        created_at,
        updated_at
      FROM
        user_comments;")

    execute(
      "TRUNCATE TABLE
        user_comments;")

    execute(
      "INSERT INTO
        comments (
          commentable_id,
          commentable_type,
          author_id,
          comment_text,
          created_at,
          updated_at)
      SELECT
        subject_id,
        'Goal',
        author_id,
        comment_text,
        created_at,
        updated_at
      FROM
        goal_comments;")
     
    execute(
      "TRUNCATE TABLE
        goal_comments;")
  end

  def down
    execute(
      "INSERT INTO
        user_comments (
          subject_id,
          author_id,
          comment_text,
          created_at,
          updated_at)
      SELECT
        commentable_id,
        author_id,
        comment_text,
        created_at,
        updated_at
      FROM
        comments
      WHERE
        commentable_type = 'user';")

    execute(
      "INSERT INTO
        goal_comments (
          subject_id,
          author_id,
          comment_text,
          created_at,
          updated_at)
      SELECT
        commentable_id,
        author_id,
        comment_text,
        created_at,
        updated_at
      FROM
        comments
      WHERE
        commentable_type = 'goal';")
    
    execute(
      "TRUNCATE TABLE
        comments;")
  end
end
