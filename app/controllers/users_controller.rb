class UsersController < ApplicationController
  before_action :require_logged_out, only: [:new, :create]

  def index
    @users_info = User.get_all_users_info
    render :index
  end

  def show
    @user = User.find_by(id: params[:id])

    if @user
      render :show
    else
      redirect_to users_url
    end
  end

  def new
    render :new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      login_user!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
