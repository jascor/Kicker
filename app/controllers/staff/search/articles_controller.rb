module Staff
  module Search
    class ArticlesController < StaffController
      def query
        unless params[:query] && params[:query].strip.length > 0
          return
        end

        query = escape_elastic_search_query(params[:query])

        @results = Article.search(sort: ['_score'],
                                 query: {
                                     query_string: {
                                         fields: ['headline'],
                                         query: "*#{query}*"
                                     }
                                 })
      end
    end
  end
end