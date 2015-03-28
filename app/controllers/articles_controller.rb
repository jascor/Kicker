class ArticlesController < ApplicationController
  def show
    @data = {}

    @data[:article] = Article.find_cached_by_slug(params[:slug].downcase)

    if @data[:article].section.slug != params[:section].downcase
      return redirect_to article_path(section: @article.section.slug)
    end

    @data[:sections] = Section.all

    @data[:read_more] = @data[:article].section.latest(4)

    @data[:custom_css] = @data[:article].custom_sass

    section_ids_concat = @data[:sections].map(&:cache_key).join(' ')

    response.headers['Surrogate-Key'] = "#{@data[:article].cache_key} #{section_ids_concat}"

    @data[:add_this_config] = {
        url: @data[:article].short_url,
        title: @data[:article].headline + ' | The Franklin Post'
    }

    unless @data[:article].article_type.nil?
      render @data[:article].article_type.layout_file_location
    end
  end

  def short_redirect
    article = Article.find_cached(params[:id])

    redirect_to "/#{article.section.name.downcase}/#{article.slug.downcase}"
  end

  def old_redirect
    article = Article.find_cached(params[:id])

    redirect_to "/#{article.section.name.downcase}/#{article.slug.downcase}"
  end

  def shows
    @data = {}

    @data[:sections] = Section.all
  end

  def index
    render layout: 'staff'
  end

  def psu_index
    render layout: 'staff'
  end
end