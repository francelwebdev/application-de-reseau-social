class UsersController < ApplicationController
    before_action :set_user, only: [:show, :like, :dislike]

  def index
    @pagy, @users = pagy(User.with_attached_profile_picture.order(created_at: :desc), items: 6)
  end

  def show
  end

  def like
      @user.liked_by current_user
      redirect_to user_path(@user)
  end

  def dislike
      @user.disliked_by current_user
      redirect_to user_path(@user)
  end

  private

  def set_user
      @user = User.find(params[:id])
  end
end
