class Item < ActiveRecord::Base
  serialize :related_articles
  serialize :tfidf
end
