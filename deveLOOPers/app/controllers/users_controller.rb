class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]
  before_action :set_user, only: [:show, :edit, :update]

  def show
    @user = User.find_by(nickname: params[:nickname])
    @pending_comments = Comment.joins(article: :user).where(users: { id: @user.id }, comments: { state: 'pending' })
    @published_articles = @user.articles.published

    if @user
      @articles = @user.articles
    else
      redirect_to root_path, alert: "User not found"
    end
  end

  def edit
    authorize_user
  end

  def update
    authorize_user
    if @user.update(user_params)
      redirect_to user_profile_path(@user), notice: 'Profile updated successfully.'
    else
      render :edit
    end
  end

  private

  def set_user
    @user = User.find_by(nickname: params[:nickname])
  end

  def user_params
    params.require(:user).permit(:nickname)
  end

  def authorize_user
    unless current_user == @user
      redirect_to root_path, alert: "You are not authorized to perform this action."
    end
  end

end
