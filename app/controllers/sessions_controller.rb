class SessionsController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(
      params[:user][:username], params[:user][:password])
    
    if @user
      redirect_to user_url(@user)
    else
      flash.now[:errors] = "Incorrect username and/or password"
      render :new
    end
  end

  def destroy
    redirect_to new_session_url
  end
end
