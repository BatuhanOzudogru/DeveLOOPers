class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @pending_comments = Comment.joins(:article).where(articles: { user_id: @user.id }, state: 'pending')
    if @user
      @articles = @user.articles
    else
      redirect_to root_path, alert: "User not found"
    end
  end
end
