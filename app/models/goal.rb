class Goal < ApplicationRecord
    validates :title, :is_private, :completed, presence: true

    belongs_to :user
end
