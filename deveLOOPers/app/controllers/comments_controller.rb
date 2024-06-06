class CommentsController < ApplicationController
    before_action :authenticate_user!

    def create
        @article = Article.find(params[:article_id])
        @comment = @article.comments.new(comment_params)
        @comment.user = current_user
        @comment.commenter = current_user.email
        if @comment.save
            redirect_to article_path(@article), notice: 'Comment was successfully created.'
          else
            redirect_to article_path(@article), alert: 'Error creating comment.'
        end
    
        
      end

    private

    def comment_params
        params.require(:comment).permit(:body)
    end
end