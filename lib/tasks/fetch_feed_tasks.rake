require 'feedjira'
require "sanitize"
require "natto"
require "nokogiri"
require "open-uri"

task :feed_fetch_task => :environment do
  natto = Natto::MeCab.new
  lists = [#"主要,http://news.livedoor.com/topics/rss/top.xml",
#    "国内,http://news.livedoor.com/topics/rss/dom.xml",
#    "海外,http://news.livedoor.com/topics/rss/int.xml",
#    "IT 経済,http://news.livedoor.com/topics/rss/eco.xml",
#    "芸能,http://news.livedoor.com/topics/rss/ent.xml",
#    "スポーツ,http://news.livedoor.com/topics/rss/spo.xml",
#    "映画,http://news.livedoor.com/rss/summary/52.xml",
#    "グルメ,http://news.livedoor.com/topics/rss/gourmet.xml",
#    "女子,http://news.livedoor.com/topics/rss/love.xml",
"トレンド,http://news.livedoor.com/topics/rss/trend.xml"
]
lists.each do |list|
  category, category_url = list.split(",")
  feed = Feedjira::Feed.fetch_and_parse(category_url)

  feed.entries.each do |entry|
    @item = Item.new
    if !Item.find_by_link(entry.url).nil?
      next
    else
      @item.title = entry.title
      @item.link = entry.url
      @item.entrydate = entry.published
      html = Nokogiri::HTML(open(entry.url))
      if html.xpath('//span[@itemprop="articleBody"]').blank?
        @item.description = entry.title
      else
        html.xpath('//span[@itemprop="articleBody"]').each do |node|
          @item.description = node.text.strip()
        end
      end
    end
    @item.save!
  end
  puts Item.last.title
end

    #p entry.title      # => "Ruby Http Client Library Performance"
    #p entry.url
    #p entry.published

    #p html.search('span itemprop="articleBody"')
    #puts html

  # feed = Feedjira::Feed.fetch_and_parse("http://news.livedoor.com/topics/rss/top.xml",
  #   :on_success => lambda {|url, feed| p "first title: " + feed.entries.first.title },
  #   :on_failure => lambda {|url, response_code, response_header, response_body| p response_body })
end
# class Tasks::FetchFeedTask
#   def self.test
#     # fetching a single feed

#     # feed and entries accessors
#     #feed.title          # => "Paul Dix Explains Nothing"
#     #feed.url            # => "http://www.pauldix.net"
#     #feed.feed_url       # => "http://feeds.feedburner.com/PaulDixExplainsNothing"
#     #feed.etag           # => "GunxqnEP4NeYhrqq9TyVKTuDnh0"
#     #feed.last_modified  # => Sat Jan 31 17:58:16 -0500 2009 # it's a Time object


#       #entry = feed.entries.first

#       #entry.url        # => "http://www.pauldix.net/2009/01/ruby-http-client-library-performance.html"
#       #entry.author     # => "Paul Dix"
#       #entry.summary    # => "..."
#       #entry.content    # => "..."
#       #entry.published  # => Thu Jan 29 17:00:19 UTC 2009 # it's a Time object
#       #entry.categories # => ["...", "..."]
#     end

#     # sanitizing an entry's content
#     #print entry.title.sanitize   # => returns the title with harmful stuff escaped
#     #entry.author.sanitize  # => returns the author with harmful stuff escaped
#     #entry.content.sanitize # => returns the content with harmful stuff escaped
#     #entry.content.sanitize! # => returns content with harmful stuff escaped and replaces original (also exists for author and title)
#     #entry.sanitize!         # => sanitizes the entry's title, author, and content in place (as in, it changes the value to clean versions)
#     #feed.sanitize_entries!  # => sanitizes all entries in place

#     # updating a single feed
#     #updated_feed = Feedjira::Feed.update(feed)

#     # an updated feed has the following extra accessors
#     #updated_feed.updated?     # returns true if any of the feed attributes have been modified. will return false if only new entries
#     #updated_feed.new_entries  # a collection of the entry objects that are newer than the latest in the feed before update

#     # fetching multiple feeds
#     #feed_urls = ["http://feeds.feedburner.com/PaulDixExplainsNothing", "http://feeds.feedburner.com/trottercashion"]
#     #feeds = Feedjira::Feed.fetch_and_parse(feed_urls)

#     # feeds is now a hash with the feed_urls as keys and the parsed feed objects as values. If an error was thrown
#     # there will be a Fixnum of the http response code instead of a feed object

#     # updating multiple feeds. it expects a collection of feed objects
#     #updated_feeds = Feedjira::Feed.update(feeds.values)

#     # defining custom behavior on failure or success. note that a return status of 304 (not updated) will call the on_success handler
#     feed = Feedjira::Feed.fetch_and_parse("http://bellonieta.net/feed/",
#       :on_success => lambda {|url, feed| p "first title: " + feed.entries.first.title },
#       :on_failure => lambda {|url, response_code, response_header, response_body| p response_body })
#     # if a collection was passed into fetch_and_parse, the handlers will be called for each one

#     # the behavior for the handlers when using Feedjira::Feed.update is slightly different. The feed passed into on_success will be
#     # the updated feed with the standard updated accessors. on failure it will be the original feed object passed into update

#     # fetching a feed via a proxy (optional)
#     #feed = Feedjira::Feed.fetch_and_parse("http://feeds.feedburner.com/PaulDixExplainsNothing", [:proxy_url => '10.0.0.1', :proxy_port => 3084])
#   end
# end