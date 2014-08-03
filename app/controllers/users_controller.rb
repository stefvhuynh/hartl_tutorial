class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end
  
  def create
    @user = User.new(user_params)
    
    if @user.save
      sign_in!(@user)
      flash[:success] = "Welcome to the app!"
      redirect_to user_url(@user)
    else
      render :new
    end
  end

  def new
    @user = User.new
    render :new
  end
  
  private
  
  def user_params
    permitted = %w[name email password password_confirmation].map(&:to_sym)
    params.require(:user).permit(permitted)
  end

end
