class CategoriesController < ApplicationController
  before_filter :user_authorize
  before_filter :privilege_filter

  def new

  end

  def edit
    begin
      render :text => Category.find(params[:id]).to_json,:layout => false
    rescue ActiveRecord::RecordNotFound
      logger.error '请求不存在的分类'
    end
  end

  def create

    begin
      categories = Category.find_by_category_name params[:category_name]
      if categories != nil
        info = '分类名已存在，请更换'
      else
        info = Category.create(:category_name => params[:category_name]) ? 'success' : '创建失败'
      end
    rescue Exception => e
      logger.error e.to_s
      info = '创建失败'
    end
    render :text => get_result(info),:layout => false
  end


  def update
    begin
      category = Category.find(params[:id])
      if category.category_name != params[:category_name].to_s && Category.find_by_category_name(params[:category_name])
        info = '分类名已存在'
      else
        category.category_name = params[:name]
        info = category.save ? 'success' : '更新失败'
      end
    rescue ActiveRecord::RecordNotFound
      logger.error '更新不存在的分类'
      info = '不存在的分类'
    rescue Exception => e
      logger.error e.to_s
      info = "更新异常"
    end
    render :text => get_result(info),:layout => false
  end


  def destroy_list
    begin
      ids = params[:id][1..params[:id].length-2].split(',')
      Category.destroy(ids)
      info = 'success'
    rescue Exception => e
      logger.error e.to_s
      info = "更新异常"
    end
    render :text => get_result(info),:layout => false
  end

  def get_categories
    categories = Category.all
    count = Category.count :all

    render :text => get_json(count,categories.to_json),:layout => false
  end
end
