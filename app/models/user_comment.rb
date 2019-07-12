class UserComment < ApplicationRecord
    validates :comment_text, presence: true

    belongs_to :subject, class_name: :User
    belongs_to :author, class_name: :User
end
