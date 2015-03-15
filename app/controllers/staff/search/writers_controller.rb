module Staff
  module Search
    class WritersController < StaffController
      def query
        unless params[:query] && params[:query].strip.length > 0
          return
        end

        query = escape_elastic_search_query(params[:query])

        @results = Writer.search(sort: ['_score'],
                                 query: {
                                     query_string: {
                                         fields: ['name'],
                                         query: "*#{query}*"
                                     }
                                 })
      end
    end
  end
end