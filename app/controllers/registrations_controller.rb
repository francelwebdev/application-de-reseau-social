class RegistrationsController < Devise::RegistrationsController
    before_action :set_user, only: [:show, :like, :dislike]
  
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