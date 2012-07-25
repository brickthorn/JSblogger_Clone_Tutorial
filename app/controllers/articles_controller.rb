class ArticlesController < ApplicationController
  before_filter :require_login, :except => [:index, :show]

  def index
    @articles = Article.order(params[:order_by])

  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    # puts params[:article]

    @article = Article.new(:title => params[:article][:title], :body => params[:article][:body])
    @article.tag_list = params[:article][:tag_list]

    # @article = Article.new(params[:article])
    # @article = Article.new
    # @article.title = params[:article][:title]
    # @article.body = params[:article][:body]

    @article.save

    redirect_to article_path(@article)
  end

  def destroy
    @article = Article.find(params[:id])

    @article.destroy

    redirect_to articles_path
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    @article.update_attributes(params[:article])

    flash[:message] = "Article '#{@article.title}' Updated!"

    redirect_to article_path(@article)
  end
end
