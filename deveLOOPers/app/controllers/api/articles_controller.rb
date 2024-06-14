class Api::ArticlesController < ApplicationController
    before_action :set_article, only: [:show]

    # GET /api/articles
    def index
      @articles = Article.published
      render json: @articles, each_serializer: ArticleSerializer
    end

    # GET /api/articles/:id
    def show
      render json: @article, serializer: ArticleSerializer
    end

    private

    def set_article
      @article = Article.find(params[:id])
    end
end

