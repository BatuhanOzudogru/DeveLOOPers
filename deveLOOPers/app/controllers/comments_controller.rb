class CommentsController < ApplicationController
    before_action :authenticate_user!

    def create
        @article = Article.find(params[:article_id])
        @comment = @article.comments.new(comment_params)
        @comment.user = current_user
        

        if @comment.save
            redirect_to article_path(@article), notice: 'Comment was successfully created.'
          else
            redirect_to article_path(@article), alert: 'Error creating comment.'
        end  
    end

    def destroy
        article = Article.find(params[:article_id])
        comment = article.comments.find(params[:id])
    
        comment.destroy if comment.written_by?(current_user)
    
        redirect_to article_path(article)
      end

    private

    def comment_params
        params.require(:comment).permit(:body)
    end
end