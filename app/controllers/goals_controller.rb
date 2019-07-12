class GoalsController < ApplicationController
    def show
        @goal = Goal.find_by(id: params[:id])
        @user = User.find_by(id: @goal.user_id)
        if @goal.privacy == 'Private' && current_user != @user
            redirect_to user_url(@user)
        else
            render :show
        end
    end

    def new
        if current_user
            render :new
        else
            redirect_to users_url
        end
    end

    def create
        @goal = Goal.new(goal_params_with_user_id)

        if @goal.save
            redirect_to goal_url(@goal)
        else
            flash.now[:errors] = @goal.errors.full_messages
            render :new
        end
    end

    def edit
        @goal = get_current_user_goal
        render :edit
    end

    def update
        @goal = get_current_user_goal

        if @goal.update_attributes(goal_params)
            redirect_to goal_url(@goal)
        else
            flash.now[:errors] = @goal.errors.full_messages
            render :edit
        end
    end

    def destroy
        @goal = get_current_user_goal
        @goal.destroy

        redirect_to user_url(current_user)
    end

    private

    def goal_params
        params
            .require(:goal)
            .permit(:user_id,
                :title,
                :description,
                :due_date,
                :privacy,
                :completion)
    end

    def goal_params_with_user_id
        goal_params.merge({ user_id: current_user.id })
    end

    def get_current_user_goal
        current_user.goals.find_by(id: params[:id])
    end
end
