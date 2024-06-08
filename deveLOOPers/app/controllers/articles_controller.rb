class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_article, only: [:show, :edit, :update, :destroy, :add_vote, :remove_vote]
  before_action :authorize_user, only: [:edit, :update, :destroy]
  def index
    @articles = Article.published.order(created_at: :asc)
  end

  def show
    @article = Article.find(params[:id])
  @comment = Comment.new # Yeni bir yorum oluşturmak için gerekli

  # Article'ın onaylanmış yorumlarını al
  @approved_comments = @article.comments.approved

  # Yalnızca mevcut kullanıcıya ait veya henüz onaylanmamış yorumları al
  @user_comments = @article.comments.where(user: current_user).or(@article.comments.pending)

  # Yorumların listesini göstermek için
  @comment_list = @approved_comments + @user_comments

  # Yalnızca makale sahibi veya yazarın henüz onaylanmamış yorumlarını al
  @pending_comments = @article.comments.pending.where(user: @article.user)

  # Eğer kullanıcı makale sahibi veya yazarı ise
  if current_user == @article.user
    # Yalnızca onay bekleyen yorumları al
    @pending_comments = @article.comments.pending
  end
  end

  def new
    @article = current_user.articles.build
  end

  def edit
  end

  def create
    @article = current_user.articles.build(article_params)
    tag_ids = params[:article][:tag_ids].present? ? params[:article][:tag_ids].reject(&:blank?) : []

    if params[:article][:new_tags].present?
      new_tag_names = params[:article][:new_tags].split(",").map(&:strip)
      new_tag_names.each do |tag_name|
        tag = Tag.find_or_create_by(name: tag_name)
        tag_ids << tag.id
      end
    end

    @article.tag_ids = tag_ids


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
    @article.vote_count += 1
    @article.save

    redirect_to @article
  end

  def remove_vote
    @article.vote_count -= 1
    @article.save

    redirect_to @article
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :content, :published, tag_ids: [])
  end

  def authorize_user
    unless @article.user == current_user
      redirect_to @article, alert: "You are not authorized to perform this action."
    end
  end
end
