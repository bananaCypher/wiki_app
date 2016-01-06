class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  load_and_authorize_resource

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    article = Article.create(article_params)
    article.update(user_id: current_user.id)
    redirect_to articles_path
  end

  def show
    @article = Article.find(params[:id])
    @comment = Comment.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    article = Article.find(params[:id])
    if current_user.role?('admin')
      article.update(params.require(:article).permit(:title, :content, :image, :user_id))
    else
      article.update(article_params)
    end
    redirect_to article_path(article)
  end

  def destroy
    Article.find(params[:id]).destroy
    redirect_to articles_path
  end

  private
  def article_params
    params.require(:article).permit(:title, :content, :image)
  end
end