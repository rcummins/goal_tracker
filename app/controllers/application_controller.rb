class ApplicationController < ActionController::Base
    private

    def login_user!(user)
        session[:session_token] = user.reset_session_token!
    end

    def logout_current_user!
        current_user.reset_session_token!
        session[:session_token] = nil
    end

    def current_user
        return nil if session[:session_token].nil?
        @current_user ||= User.find_by(session_token: session[:session_token])
    end
end
