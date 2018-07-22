require 'open-uri'
class CreateReaderWorker < BaseWorker
  attr_reader :feed, :feed_url

  def perform(feed_id)
    @feed = Feed.find_by(id: feed_id)
    @feed_url = feed&.url

    if feed_url =~ URI::regexp
      create_feed_readers
    end
  end

  def create_feed_readers
    doc = Nokogiri::XML(open(feed_url))
    blogs = doc.css('item')
    unless blogs.empty?
      feed.update_columns(title: doc.at("title").text)
      blogs.each do |data|
        feed.readers.create!(
          title: data.at("title").text,
          url: data.at("link").text,
          description: data.at("description").text,
          published: data.at("pubDate").text
        )
      end
    end
  end
end
