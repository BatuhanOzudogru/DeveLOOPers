class UsersController < ApplicationController
  def show
    @user = User.find_by_id(params[:id])
    if @user
      @articles = @user.articles.published
    else
      redirect_to root_path, alert: "User not found"
    end
  end
  
end
