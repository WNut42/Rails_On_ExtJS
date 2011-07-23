class CreateArticles < ActiveRecord::Migration
  def self.up
    create_table :articles do |t|
      t.string      :title                                          #文章标题
      t.integer     :category_id                                    #所属分类
      t.text        :content                                        #文章内容
      t.integer     :priority                                       #文章优先级，0-正常，1-顶置

      t.integer     :is_locked     ,:limit => 1 ,:default => 0      #锁定 1为True 0为False
      t.integer     :lock_version  ,:default => 0                   #乐观锁
      t.timestamps
    end
  end

  def self.down
    drop_table :articles
  end
end
