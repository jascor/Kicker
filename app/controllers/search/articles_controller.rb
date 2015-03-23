module Search
  class ArticlesController < ApplicationController
    skip_before_action :fastly_cache_until_purged

    def query
      unless params[:query] && params[:query].strip.length > 0
        @results = []
        return
      end

      query = escape_elastic_search_query(params[:query])

      @results = Article.search(sort: ['_score'],
                                query: {
                                    query_string: {
                                        fields: ['headline', 'contents'],
                                        query: "*#{query}*"
                                    }
                                })
    end
  end
end