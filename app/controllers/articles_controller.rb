class ArticlesController < ApplicationController

  # http_basic_authenticate_with name: "manish", password: "123",
  #                              except: [:index, :show]
  before_action :require_user, only: [:index, :show, :new]

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
    # binding.pry
    # @article = Article.new(params[:article])
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render 'new'
    end
    # render plain: params[:article]
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path
  end


  private
  def article_params
    params.require(:article).permit(:title, :text)
  end

end
