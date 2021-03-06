class CommentsController < ApplicationController
  before_action :set_article
  
  def create
    unless current_user
      flash[:alert] = "Please sign in or sign up first"
      redirect_to new_user_session_path and return
    else
      @comment = @article.comments.build(comment_params)
      @comment.user = current_user
    
      if @comment.save
        ActionCable.server.broadcast "comments",
          render(partial: 'comments/comment', object: @comment)
        flash[:notice] = "Comment has been created"
      else
        flash.now[:alert] = "Comment has not been created"
        redirect_to article_path(@article) and return
      end
      # 
    end
  end
    
  # def create
  #   unless current_user
  #     flash[:alert] = "Please sign in or sign up before you can post a comment"
  #     redirect_to(new_user_session_path) and return
  #   else
  #     @comment = @article.comments.build(comment_params)
  #     @comment.user = current_user
  #
  #     if @comment.save
  #       # action cable
  #         ActionCable.server.broadcast "comments", render(partial: 'comments/comment', object: @comment )
  #         flash[:notice] = "Comment has been created"
  #         redirect_to article_path(@article) and return
  #     else
  #       flash[:alert] = "Comment has not been created"
  #     end
  #     redirect_to(article_path(@article)) and return
  #   end
  # end
  
  private
  
  def comment_params
    params.require(:comment).permit(:body)
  end
  def set_article
    @article = Article.find(params[:article_id])
  end
end
