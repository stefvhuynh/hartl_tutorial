class UsersController < ApplicationController
  before_action :require_signed_in!, only: [:show, :edit, :update]
  before_action :require_current_user!, except: [:new, :create]

  def show
    @user = User.find(params[:id])
    render :show
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
    if signed_in?
      flash[:notice] = "You already have an account!"
      redirect_to root_url
    else
      @user = User.new
      render :new
    end
  end
  
  def update
    @user = User.find(params[:id])
    
    if @user.update(user_params)
      sign_in!(@user)
      flash[:success] = "Profile updated!"
      redirect_to user_url(@user)
    else
      render :edit
    end
  end
  
  def edit
    @user = User.find(params[:id])
    render :edit
  end
  
  private
  
  def user_params
    permitted = %w[name email password password_confirmation].map(&:to_sym)
    params.require(:user).permit(permitted)
  end
  
  def require_signed_in!
    unless signed_in?
      flash[:notice] = "Please sign in" 
      redirect_to root_url
    end
  end
  
  def require_current_user!
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to root_url
    end
  end

end
