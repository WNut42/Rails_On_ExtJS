class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.string      :category_name                                  #分类名称

      t.integer     :is_locked     ,:limit => 1 ,:default => 0      #锁定 1为True 0为False
      t.integer     :lock_version  ,:default => 0                   #乐观锁
      t.timestamps
    end
  end

  def self.down
    drop_table :categories
  end
end
