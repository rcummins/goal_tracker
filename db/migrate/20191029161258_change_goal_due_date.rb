class ChangeGoalDueDate < ActiveRecord::Migration[5.2]
  def up
    change_column :goals, :due_date, :date
  end

  def down
    change_column :goals, :due_date, :datetime
  end
end
