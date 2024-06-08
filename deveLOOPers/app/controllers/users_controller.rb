class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @pending_comments = Comment.joins(article: :user).where(users: { id: @user.id }, comments: { state: 'pending' })

    if @user
      @articles = @user.articles
    else
      redirect_to root_path, alert: "User not found"
    end
  end
end
