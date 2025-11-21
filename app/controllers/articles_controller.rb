class ArticlesController < ApplicationController
  before_action :require_login, only: [:new, :create, :edit, :update, :destroy]

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    @article = current_user.articles.new(article_params)
    if @article.save
      flash[:notice] = "Article was successfully created."
      redirect_to root_path
    else
      flash.now[:alert] = "There were some errors while creating the article."
      render :new
    end
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      flash[:notice] = "Article was successfully updated."
      redirect_to root_path
    else
      flash.now[:alert] = "There were some errors while updating the article."
      render :edit
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    flash[:notice] = "Article was successfully deleted."
    redirect_to root_path, status: :see_other
  end
  
  def article_params
    params.expect(article: [:title, :body])
  end
  def comment_params
    params.expect(comment: [:commenter , :body])  
  end
end
