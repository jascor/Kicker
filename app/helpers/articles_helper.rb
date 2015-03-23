module ArticlesHelper
  def publishing_time(ar_timestamp)
    if ar_timestamp.is_a?(String)
      ar_timestamp = Date.parse(ar_timestamp)
    end

    ar_timestamp.strftime('%m.%d.%Y')
  end

  def link_to_article(article)
    "/#{article.section.slug}/#{article.slug}"
  end

  def full_link_to_article(article)
    "http://www.fhspost.com#{link_to_article(article)}"
  end

  def short_link_to_article(id)
    "/short/a/#{id}"
  end
end