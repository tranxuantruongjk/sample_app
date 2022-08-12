class UsersController < ApplicationController
  before_action :logged_in_user, only: %i(index edit update destroy)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: %i(destroy)
  before_action :find_user, only: %i(show edit update destroy)

  def new
    @user = User.new
  end

  def show; end

  def index
    @pagy, @users = pagy(User.all,
                         page: params[:page],
                         items: Settings.pagy.items_per_page)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = t(".welcome")
      redirect_to @user
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:success] = t(".updated")
      redirect_to @user
    else
      flash[:danger] = t(".update_failed")
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t(".deleted")
    else
      flash[:danger] = t(".delete_failed")
    end
    redirect_to users_url
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = t(".please_log_in")
    redirect_to login_url
  end

  def correct_user
    redirect_to(root_url) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  def find_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t(".not_found_user")
    redirect_to root_path
  end
end
