class SessionsController < ApplicationController

  before_action :check_session, only: [:new, :create]

  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(username, password)
    if @user
      login_user!
      redirect_to cats_url
    else
      render :new
    end
  end

  def destroy
    current_user.reset_session_token!
    current_user.save!
    session[:session_token] = nil
    redirect_to cats_url
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

  def username
    user_params[:username]
  end

  def password
    user_params[:password]
  end

  def check_session
    if current_user
      flash[:error] = "You must be logged out to access this section"
      redirect_to cats_url
    end
  end

end
