class User < ActiveRecord::Base
  
  def self.find_for_page page_begin,page_end
    find :all,:offset => page_begin,:limit => page_end
  end
end
