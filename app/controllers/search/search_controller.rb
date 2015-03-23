module Search
  class SearchController < ApplicationController
    skip_before_action :fastly_cache_until_purged

    def index
      @data = {}

      @data[:sections] = Section.all

      if params[:q] && params[:q].strip.length > 0
        query = escape_elastic_search_query(params[:q])

        page = (params[:p] || 1).to_i

        @data[:query] = query

        @data[:current_page] = page

        @data[:results] = Article.search(sort: ['_score'],
                                  query: {
                                      query_string: {
                                          fields: ['headline', 'contents'],
                                          query: "*#{query}*"
                                      }
                                  }).page(page).per(15)
      end

      render 'search/index'
    end
  end
end