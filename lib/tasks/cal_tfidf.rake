require "natto"
task :cal_tfidf => :environment do
  natto = Natto::MeCab.new
  lists = ["主要,http://news.livedoor.com/topics/rss/top.xml",
    "国内,http://news.livedoor.com/topics/rss/dom.xml",
    "海外,http://news.livedoor.com/topics/rss/int.xml",
    "IT 経済,http://news.livedoor.com/topics/rss/eco.xml",
    "芸能,http://news.livedoor.com/topics/rss/ent.xml",
    "スポーツ,http://news.livedoor.com/topics/rss/spo.xml",
    "映画,http://news.livedoor.com/rss/summary/52.xml",
    "グルメ,http://news.livedoor.com/topics/rss/gourmet.xml",
    "女子,http://news.livedoor.com/topics/rss/love.xml",
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
        @item.category = category
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
  end
end
