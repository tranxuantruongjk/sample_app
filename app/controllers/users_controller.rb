class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(new create show)
  before_action :find_user, except: %i(index new create)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: %i(destroy)

  def new
    @user = User.new
  end

  def show
    @page, @microposts = pagy @user.microposts,
                              items: Settings.pagy.items_per_page
  end

  def index
    @pagy, @users = pagy(User.all,
                         page: params[:page],
                         items: Settings.pagy.items_per_page)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = t ".check_for_activate"
      redirect_to root_url
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

  def following
    @title = t ".following"
    @pagy, @users = pagy @user.following, items: Settings.pagy.items_per_page
    render :show_follow
  end

  def followers
    @title = t ".followers"
    @pagy, @users = pagy @user.followers, items: Settings.pagy.items_per_page
    render :show_follow
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
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
