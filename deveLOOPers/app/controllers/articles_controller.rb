class ArticlesController < ApplicationController
    before_action :set_article, only: [:show, :edit, :update, :destroy]
   

    def index
      @articles = Article.published.order(created_at: :asc)
    end
  
    def show
    end
  
    def new
      @article = Article.new
    end
  
    def edit
      @article = Article.find(params[:id])
    end
  
    def create
      @article = Article.new(article_params)
  
      if @article.save
        redirect_to @article, notice: 'Article was successfully created.'
      else
        render :new, status: :unprocessable_entity
      end
    end
  
    def update
      if @article.update(article_params)
        redirect_to @article, notice: 'Article was successfully updated.'
      else
        render :edit
      end
    end
  
    def destroy
      @article.destroy
      redirect_to articles_url, notice: 'Article was successfully destroyed.'
    end

    def add_vote
      article = Article.find(params[:article_id])
      article.vote_count += 1
      article.save
  
      redirect_to articles_path(article)
    end
  
    private
  
    def set_article
      @article = Article.find(params[:id])
    end
  
    def article_params
      params.require(:article).permit(:title, :content, :published)
    end
  end
