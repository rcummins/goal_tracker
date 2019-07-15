class User < ApplicationRecord
    validates :username, presence: true, uniqueness: true
    validates :password_digest, presence: true
    validates :session_token, presence: true, uniqueness: true
    validates :password, length: { minimum: 8}, allow_nil: true

    has_many :goals
    has_many :comments_received,
        foreign_key: :subject_id,
        class_name: :UserComment
    has_many :user_comments_authored,
        foreign_key: :author_id,
        class_name: :UserComment
    has_many :goal_comments_authored,
        foreign_key: :author_id,
        class_name: :GoalComment

    after_initialize :ensure_session_token

    attr_reader :password
    
    def self.find_by_credentials(username, password)
        user = User.find_by(username: username)

        return user if user && user.is_password?(password)
        return nil
    end

    def self.get_all_users_info
        User
            .select(
                "users.id,
                users.username,
                users.session_token,
                users.created_at,
                COUNT(goals.id) AS total_goals,
                SUM(
                    CASE
                        WHEN goals.completion = 'Completed' THEN 1
                        ELSE 0
                    END) AS completed_goals"
            )
            .left_outer_joins(:goals)
            .group(
                'users.id,
                users.username,
                users.session_token,
                users.created_at'
            )
    end

    def ensure_session_token
        self.session_token ||= generate_unique_session_token
    end

    def reset_session_token!
        previous_token = self.session_token
        
        # generate a new token and make sure it's different from previous token
        while self.session_token == previous_token
            self.session_token = generate_unique_session_token
        end

        self.save!

        return self.session_token
    end

    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end

    def is_password?(password)
        BCrypt::Password.new(self.password_digest).is_password?(password)
    end

    private

    def generate_unique_session_token
        token = SecureRandom.urlsafe_base64(16)

        # generate a new token if this one is already taken
        while self.class.exists?(session_token: token)
            token = SecureRandom.urlsafe_base64(16)
        end

        return token
    end
end
