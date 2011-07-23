class ArticlesController < ApplicationController
  include_kindeditor :only => [:new, :show]

  def new

  end

  def show
    
  end

  def edit
    begin
      render :text => Article.find(params[:id]).to_json,:layout => false
    rescue ActiveRecord::RecordNotFound
      logger.error '请求不存在的文章'
    end
  end

  def create

    begin
      articles = Article.find_by_title params[:title]
      if articles != nil
        info = '文章名已存在，请更换'
      else
        article = Article.new
        article.title = params[:title]
        article.content = params[:content]
        article.category_id = params[:category_id]
        article.priority = params[:priority]
        info = article.save! ? 'success' : '文章创建异常'
      end
    rescue Exception => e
      logger.error e.to_s
      info = '文章创建异常'
    end
    render :text => get_result(info),:layout => false
  end


  def update
    begin
      article = Article.find(params[:id])
      if article.title != params[:title].to_s && Article.find_by_title(params[:title])
        info = '文章名已存在'
      else
        article.title = params[:title]
        article.content = params[:content]
        article.category_id = params[:category_id]
        article.priority = params[:priority]
        info = article.save! ? 'success' : '文章更新异常'
      end
    rescue Exception => e
      logger.error e.to_s
      info = "更新异常"
    end
    render :text => get_result(info),:layout => false
  end


  def destroy_list
    begin
      ids = params[:id][1..params[:id].length-2].split(',')
      Article.destroy(ids)
      info = 'success'
    rescue Exception => e
      logger.error e.to_s
      info = "更新异常"
    end
    render :text => get_result(info),:layout => false
  end

  def get_articles_for_page
    articles = Article.find_for_page params[:start].to_i,params[:limit].to_i
    count = Article.count :all

    render :text => get_json(count,articles.to_json(:include => [:category])),:layout => false
  end
end
