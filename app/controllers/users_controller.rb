class UsersController < ApplicationController


  def new

  end

  def edit
    begin
      render :text => User.find(params[:id]).to_json,:layout => false
    rescue ActiveRecord::RecordNotFound
      logger.error '请求不存在的用户'
    end
  end

  def create

    begin
      users = User.find_by_name params[:name]
      if users != nil
        info = '用户名已存在，请更换'
      else
        info = (User.create(:name => params[:name].to_s,:age => params[:age].to_i,:password => params[:name].to_s) ? 'success' : '更新失败')
      end
    rescue Exception => e
      logger.info e.to_s
      info = '更新失败'
    end
    render :text => get_result(info),:layout => false
  end


  def update
    begin
      user = User.find(params[:id])
      if user.name != params[:name].to_s && User.find_by_name(params[:name])
        info = '用户名已存在'
      else
        user.name = params[:name]
        user.age = params[:age]
        info = user.save ? 'success' : '更新失败'
      end
    rescue ActiveRecord::RecordNotFound
      logger.error '更新不存在的用户'
      info = '不存在的用户'
    end
    render :text => get_result(info),:layout => false
  end


  def destroy
    begin
      ids = params[:id][1..params[:id].length-2].split(',')
      User.destroy(ids)
      info = 'success'
    rescue Exception => e
      logger.error e.to_s
      info e.to_s
    end
    render :text => get_result(info),:layout => false
  end

  def get_users_for_page
    users = User.find_for_page params[:start].to_i,params[:limit].to_i 
    count = User.count :all
    json_str = get_json count,users.to_json
    
    render :text => json_str,:layout => false
  end
end
