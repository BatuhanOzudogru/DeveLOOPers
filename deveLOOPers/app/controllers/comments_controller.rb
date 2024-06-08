class CommentsController < ApplicationController
    before_action :set_article
    before_action :set_comment, only: [:approve, :reject, :destroy]
  
    def create
      @comment = @article.comments.new(comment_params)
      @comment.user = current_user
      if @comment.save
        redirect_to @article, notice: 'Comment was successfully created.'
      else
        redirect_to @article, alert: 'Failed to create comment.'
      end
    end
  
    def destroy
      @comment.destroy
      redirect_to @article, notice: 'Comment was successfully deleted.'
    end
  
    def approve
      if current_user == @article.user
        @comment.update(state: 'approved')
        redirect_to user_profile_path(current_user), notice: 'Comment was approved.'
      else
        redirect_to user_profile_path(current_user), alert: 'Not authorized to approve this comment.'
      end
    end
  
    def reject
      if current_user == @article.user
        @comment.destroy
        redirect_to user_profile_path(current_user), notice: 'Comment was rejected.'
      else
        redirect_to user_profile_path(current_user), alert: 'Not authorized to reject this comment.'
      end
    end
  
    private
  
    def set_article
      @article = Article.find(params[:article_id])
    end
  
    def set_comment
      @comment = @article.comments.find(params[:id])
    end
  
    def comment_params
      params.require(:comment).permit(:body)
    end
  end
  