class Comment < ApplicationRecord
    validates :comment_text, presence: true

    belongs_to :commentable, polymorphic: true
    belongs_to :author, class_name: :User
end
