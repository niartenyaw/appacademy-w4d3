class UsersController < ApplicationController

  before_action :check_session, only: [:new, :create]

  def new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login_user!
      redirect_to cats_url
    else
      redirect_to new_user_url
    end
  end

  def show
    @user = User.find_by(id: params[:id])
  end


  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

  def check_session
    if current_user
      flash[:error] = "You must be logged out to access this section"
      redirect_to cats_url
    end
  end
end
