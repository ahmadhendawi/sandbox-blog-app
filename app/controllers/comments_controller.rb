class CommentsController < ApplicationController
  before_action :require_login, only: [:create]
 
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      flash[:notice] = "Comment was successfully created."
      redirect_to article_path(@article)
    end
  end
  #if i used @article.comments.create ... it would save directly without validation and without if @comment.save check
  private
  def comment_params
    params.require(:comment).permit(:body)
  end
end

# #this below sits the article_id manually
# class CommentsController < ApplicationController
#   def create
#     @comment = Comment.new(comment_params)
#     @comment.article_id = params[:article_id]
#     if @comment.save
#       flash[:notice] = "Comment was successfully created."
#       redirect_to article_path(@comment.article)
#     end
#   end
#   private
#   def comment_params
#     params.require(:comment).permit(:commenter, :body)
#   end