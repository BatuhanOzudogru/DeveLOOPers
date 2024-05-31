class WelcomeController < ApplicationController
    def index
        @articles = Article.where(published: true)
    end
end
