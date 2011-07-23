class Article < ActiveRecord::Base
  belongs_to :category

  def self.find_for_page page_begin,page_end
    find :all,:offset => page_begin,:limit => page_end,:order => 'priority DESC'
  end
end
