class SectionsController < ApplicationController
  def show
    @data = {}

    @data[:sections] = Section.all_cached

    @data[:section] = Section.find_cached_by_slug(params[:section_slug])

    @data[:featured] = Article.get_most_important_published(Time.now - 1.month, 10, true, @data[:section].id)

    @data[:latest] = Article.latest_with_assoc(15, @data[:featured].map(&:id), @data[:section].id)

    section_ids_concat = @data[:sections].map(&:cache_key)
    featured_ids_concat = @data[:featured].map(&:cache_key).join(' ')
    latest_ids_concat = @data[:latest].map(&:cache_key).join(' ')

    response.headers['Surrogate-Key'] = "#{section_ids_concat} #{featured_ids_concat} #{latest_ids_concat}"
  end

  def show_page
    @data = {}

    @data[:sections] = Section.all_cached

    @data[:section] = Section.find_cached_by_slug(params[:section_slug])

    page = (params[:page] || 1).to_i

    @data[:current_page] = page

    @data[:paginated_articles] = Article.with_assoc.where(section_id: @data[:section].id, published: true, private: false).order(published_at: :desc).page(page).per(15)

    section_ids_concat = @data[:sections].map(&:cache_key)
    article_ids_concat = @data[:paginated_articles].map(&:cache_key).join(' ')

    response.headers['Surrogate-Key'] = "#{section_ids_concat} #{article_ids_concat}"
  end
end
