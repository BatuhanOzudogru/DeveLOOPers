class CommentsController < ApplicationController
    before_action :set_article
    before_action :set_comment, only: [:destroy, :approve, :reject, :show]
  
    def create
      @comment = @article.comments.new(comment_params)
      @comment.user = current_user
      
      if @comment.save
        redirect_to @article, notice: 'Comment was successfully created.'
      else
        redirect_to @article, alert: 'Failed to create comment.'
      end
    end
    
    def index
       @pending_comments = current_user == @article.user ? @article.comments.pending : []
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

    def show
        @comment = @article.comments.find(params[:id])
        if @comment.written_by?(current_user) || (@comment.state == "pending" && current_user == @article.user)
          render :show
        else
          redirect_to root_path, alert: "You are not authorized to view this comment."
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
      params.require(:comment).permit(:body, :commenter)
    end
end
  