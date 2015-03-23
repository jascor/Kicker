class SiteController < ApplicationController
  def index
    @data = {}

    @data[:sections] = Section.all_cached

    @data[:sections_featured_articles] = []
    @data[:sections_latest_articles] = []

    @data[:sections].each do |section|
      featured = Article.get_most_important_published(Time.now - 1.month, 1, true, section.id, 'fpSectionFeaturedFor_')[0]

      @data[:sections_featured_articles].push(featured)

      @data[:sections_latest_articles].push(Article.latest_with_assoc(7, (featured.id || nil), section.id, 'fpSectionLatestFor_'))
    end

    @data[:featured] = Article.get_most_important_published(Time.now - 1.month, 10, true)

    @data[:latest] = Article.latest_with_assoc(15, @data[:featured].map(&:id))

    section_names_concat = @data[:sections].map(&:cache_key).join(' ')
    featured_ids_content = @data[:featured].map(&:cache_key).join(' ')
    latest_ids_concat = @data[:latest].map(&:cache_key).join(' ')

    response.headers['Surrogate-Key'] = "front-page #{section_names_concat} #{featured_ids_content} #{latest_ids_concat}"

    request.session_options = {}
  end
end