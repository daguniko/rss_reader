class Item < ActiveRecord::Base
  serialize :related_articles
end
