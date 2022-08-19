class MicropostsController < ApplicationController
  before_action :logged_in_user, only: %i(create destroy)
  before_action :correct_user, only: :destroy
  before_action :create_micropost, only: :create

  def create
    if @micropost.save
      flash[:success] = t ".success"
      redirect_to root_url
    else
      @pagy, @feed_items = pagy current_user.feed,
                                items: Settings.pagy.items_per_page
      render "static_pages/home"
    end
  end

  def destroy
    if @micropost.destroy
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".fail"
    end
    redirect_to request.referer || root_url
  end

  private
  def micropost_params
    params.require(:micropost).permit :content, :image
  end

  def correct_user
    @micropost = current_user.microposts.find_by id: params[:id]
    return if @micropost

    flash[:danger] = t ".invalid"
    redirect_to request.referer || root_url
  end

  def create_micropost
    @micropost = current_user.microposts.build(micropost_params)
    @micropost.image.attach(params[:micropost][:image])
  end
end
