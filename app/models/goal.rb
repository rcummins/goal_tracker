class Goal < ApplicationRecord
    validates :title, :privacy, :completion, presence: true
    validates :privacy, inclusion: { in: ['Public', 'Private'] }
    validates :completion, inclusion: { in: ['Not completed', 'Completed'] }

    belongs_to :user

    has_many :comments_received,
        foreign_key: :subject_id,
        class_name: :GoalComment
end
