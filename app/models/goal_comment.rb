class GoalComment < ApplicationRecord
    validates :comment_text, presence: true

    belongs_to :subject, class_name: :Goal
    belongs_to :author, class_name: :User
end
