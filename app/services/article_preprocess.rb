class ArticlePreprocess
  include ActionView::Context
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::TextHelper
  include React::Rails::ViewHelper

  MATCH_TAGS = /{{\s*[a-zA-Z0-9_-]+\s*.+?}}/

  GET_TAG_TYPE = /{{\s*([a-zA-Z0-9_-]+)\s*.+}}/

  GET_TAG_VALUES = /{{\s*[a-zA-Z0-9_-]+\s*(.+)}}/

  VALID_TAGS = Regexp.union 'image', 'image_slideshow', 'twitter', 'quote', 'youtube', 'link_to_article', 'link'

  VALID_NESTED_TAGS = Regexp.union 'link_to_article'

  def initialize(contents)
    @article = contents
  end

  def execute
    @article.scan(MATCH_TAGS).each do |a|
      processed_string = process a

      next if processed_string.nil?

      @article.gsub!(a, processed_string)
    end

    @article
  end

  def process(tag)
    type = get_tag_type tag

    return nil unless type.match(VALID_TAGS)

    if self.respond_to?("process_#{type}".to_sym)
      value = get_tag_values tag
      self.send("process_#{type}", value)
    else
      nil
    end
  end

  def process_image(id)
    id.lstrip!
    id.rstrip!

    if id.match(/^\d+\s+\([a-z]+\)$/)
      size = id.match(/^\d+\s+\(([a-z]+)\)$/)[1]
      id = id.match(/^(\d+)\s+\([a-z]+\)$/)[1]
    else
      return nil unless id.match(/^\d+$/)

      size = nil
    end

    media = Medium.find_by_id(id)

    return nil unless media

    "<figure class=\"visual inline\">\n<img src=\"#{media.link}\" />\n<p class=\"caption\">#{media.caption} <span class=\"credit\">#{media.credit}</span></p>\n</figure>"
  end

  def process_image_slideshow(ids)
    ids.lstrip!
    ids.rstrip!

    image_ids = ids.split(' ')

    return nil if image_ids.length < 1

    images = []

    image_ids.each do |id|
      if crap = Medium.find_by_id(id)
        images.push(crap)
      end
    end

    return nil if images.length < 1

    media_collection = MediaCollection.create

    images.each_with_index do |image, index|
      MediaCollectionContent.create({ media_collection_id: media_collection.id, medium_id: image.id, position: index + 1 })
    end

    slideshow_data = media_collection.formatted_slide_props

    react_component('InlineSlideshow', slideshow_data, { prerender: true })
  end

  def process_twitter(id)
    id.lstrip!
    id.rstrip!

    return nil unless id.match(/^\d+$/)

    tweet = get_tweet id

    if tweet.nil?
      nil
    else
      tweet
    end
  end

  def process_quote(values)
    values.lstrip!
    values.rstrip!

    return nil unless values.match(/[a-zA-Z]+\s+\(.+\)\s+\[.+\]/)

    size = values.match(/([a-zA-Z]+)\s+\(.+\)\s+\[.+\]/)[1]
    author = values.match(/[a-zA-Z]+\s+\((.+)\)\s+\[.+\]/)[1]
    quote = values.match(/[a-zA-Z]+\s+\(.+\)\s+\[(.+)\]/)[1]

    "<blockquote class='article_inline_quote #{size}'>\n<p>#{quote}</p>\n<footer class='article_quote_byline'>\n<cite class='quote_author_byline'>#{author}</cite>\n</footer>\n</blockquote>"
  end

  def process_link(values)
    return nil unless values.match(/\(.*\)\s*\[.+\]/)

    link_hypertext = values.match(/\((.*)\)\s*\[.+\]/)[1]

    link_hypertext.lstrip!
    link_hypertext.rstrip!

    link_href = values.match(/\(.*\)\s*\[(.+)\]/)[1]

    "<a href='#{ActionView::Base.full_sanitizer.sanitize(link_href)}'>#{link_hypertext.length > 0 ? ActionView::Base.full_sanitizer.sanitize(link_hypertext) : ActionView::Base.full_sanitizer.sanitize(link_href) }</a>"
  end

  def process_link_to_article(values)
    return nil unless values.match(/\d+\s*\[.*\]/)

    id = values.match(/(\d+)\s*\[.*\]/)[1]
    hypertext = values.match(/\d+\s*\[(.*)\]/)[1]
    hypertext.lstrip!
    hypertext.rstrip!

    article = Article.includes(:section).find_by_id(id)

    return nil unless article && article.published && !article.private

    "<a href='http://www.franklinpost.org/articles/#{article.section.name.downcase}/#{article.created_at.strftime('%Y/%m/%d')}/#{article.id}/#{article.slug}'>#{hypertext.length > 0 ? hypertext : article.headline}</a>"
  end

  def process_image_multiple(values)
    ids = values.split(' ')

    images = ''

    ids.each do |i|
      i = i.to_i
      media = Media.find(i)
      next if media.nil?

      images += "<div class='article_inline_contents_img regular_inline_img full'>\n<img class='img_article_full' src='#{media.link}' alt='#{media.alt_text}'>\n<span class='article_inline_img_caption'>#{media.caption} (#{media.credit})</span>\n</div>"
    end

    images
  end

  private

  def get_tag_type(tag)
    tag.match(GET_TAG_TYPE)[1]
  end

  def get_tag_values(tag)
    tag.match(GET_TAG_VALUES)[1]
  end

  def get_tweet(id)
    begin
      request = PatronHTTP.get 'https://api.twitter.com', 5000, nil, "/1/statuses/oembed.json?id=#{id}&align=center"
    rescue Exceptions::PatronHTTPRequestError
      return nil
    end

    JSON.parse(request)['html']
  end

  def get_yt_video_embed(id)
    begin
      request = PatronHTTP.get ''
    end
  end
end