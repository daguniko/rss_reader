require 'rss'

filename = 'http://news.livedoor.com/topics/rss/top.xml'
rss = RSS::Parser.parse(filename)
rss.items.each{|item|
  puts item.title
  puts item.link
  p item.description
  puts
}

#