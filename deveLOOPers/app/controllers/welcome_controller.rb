class WelcomeController < ApplicationController
    def index
        @articles = Article.where(published: true)
        @user = User.find_by_id(params[:id])
    end
end
