class GoalCommentsController < ApplicationController
    def new
        render :new
    end

    def create
        @goal_comment = GoalComment.new(goal_comment_params)

        if @goal_comment.save
            redirect_to goal_url(@goal_comment.subject_id)
        else
            flash[:errors] = @goal_comment.errors.full_messages
            redirect_to new_goal_goal_comment_url(@goal_comment.subject_id)
        end
    end

    private

    def goal_comment_params
        params
            .require(:goal_comment)
            .permit(:subject_id, :comment_text)
            .merge({ author_id: current_user.id })
    end
end
