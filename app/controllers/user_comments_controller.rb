class UserCommentsController < ApplicationController
    def new
        render :new
    end

    def create
        @user_comment = UserComment.new(user_comment_params)

        if @user_comment.save
            redirect_to user_url(@user_comment.subject_id)
        else
            flash[:errors] = @user_comment.errors.full_messages
            redirect_to new_user_user_comment_url(@user_comment.subject_id)
        end
    end

    private

    def user_comment_params
        params
            .require(:user_comment)
            .permit(:subject_id, :comment_text)
            .merge({ author_id: current_user.id })
    end
end
