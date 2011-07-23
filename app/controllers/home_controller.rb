class HomeController < ApplicationController
  before_filter :user_authorize,:except => [:login,:validate_user]
  before_filter :privilege_filter

  def index
    @menus = @@menus_map[1].to_json
  end

  #用户登录时的验证
  def validate_user
    user = User.find(:first,:conditions => ['name = ? AND password = ?',params[:login_name],params[:login_pwd]])
    if user == nil
      info = '用户名或密码错误'
    else
      session[:user_id] = user.id
      info = 'success'
    end
    render :text => get_result(info),:layout => false 
  end

  #退出系统
  def logout
    reset_session
    render :text => get_result('注销成功'), :layout => false
  end


  private

  @@menus_map = {
    1 => [
      # === 文章管理 ===
      { :id => 1, :name => '文章管理', :image => '/images/system/plugin.gif',
        :url => 'articles', :qtip => '文章管理', :leaf => false,
        :children => [
          # --- 文章分类 ---
          { :id => 10, :name => '文章分类', :image => '/images/system/plugin.gif',
            :url => '/categories', :qtip => '文章分类', :leaf => true
          },
          # --- 文章管理 ---
          { :id => 11, :name => '文章管理', :image => '/images/system/plugin.gif',
            :url => '/articles', :qtip => '文章管理', :leaf => true
          }
        ]
      },
      # === 后台管理 ===
      { :id => 2, :name => '后台管理', :image => '/images/system/plugin.gif',
        :url => 'users', :qtip => '后台管理', :leaf => false,
        :children => [
          # --- 用户管理 ---
          { :id => 20, :name => '用户管理', :image => '/images/system/plugin.gif',
            :url => '/users', :qtip => '用户管理', :leaf => true
          }
        ]
      }
      
    ]
  }
end
