class ArticlesController < ApplicationController
  def show
    @article = Article.find_cached_by_slug(params[:slug])

    if @article.section.slug != params[:section] ||
        @article.subsection.slug != params[:subsection]
      return redirect_to article_path(section: @article.section.slug, subsection: @article.subsection.slug)
    end

    unless @article.article_type.nil?
      render @article.article_type.layout_file_location
    end
  end

  def index
    render layout: 'staff'
  end

  def psu_index
    render layout: 'staff'
  end
end