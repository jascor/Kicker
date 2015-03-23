window.FullScreenSearchBox = React.createClass({
    articlesSearchURL: '/api.v1/search/articles',

    getInitialState: function()
    {
        return {
            totalResults: null,
            results: []
        }
    },

    componentDidMount: function()
    {
        var self = this;

        document.body.classList.add('modalSearch');

        key('esc', this.destroySearchBox);

        this.getDOMNode().addEventListener('keyup', function(e)
        {
           if (e.keyCode === 27)
           {
               self.destroySearchBox();
           }
        });

        this.debouncedInputQuery = _.debounce(function(event)
        {
            self.doSearch(event.target.value);
        }, 250);

        this.getDOMNode().querySelector('#modalSearchQueryInput').focus();
    },

    componentWillUnmount: function()
    {
        key.unbind('esc', this.destroySearchBox);
    },

    render: function()
    {
        return (
            <div id="modalOverlay" className="modalSearch overlay fancy">
                <div className="closeModal" onClick={this.destroySearchBox}></div>
                <div className="searchBox">
                    <input id="modalSearchQueryInput" placeholder="Search Query" type="text" name="query" onInput={this.didEnterQuery} />
                </div>
                <div className="totalResults">{this.totalResultsText()}</div>
                <div className="results">
                { this.state.results.map(function(object)
                {
                    return (
                        <div key={object.id} className="result">
                            <a href={object.link}>
                                <span className="title">{object.title}</span>
                            </a>

                            <time datetime={object.additional_info.published_at}>{object.additional_info.pretty_publishing_time}</time>
                        </div>
                    );
                })}
                </div>
            </div>
        );
    },

    totalResultsText: function()
    {
        if (this.state.totalResults === null)
        {
            return '';
        }

        return this.state.totalResults + ' total results';
    },

    didEnterQuery: function(event)
    {
        event.persist();

        this.debouncedInputQuery(event);
    },

    destroySearchBox: function()
    {
        React.unmountComponentAtNode(document.getElementById('modalOutlet'));

        document.body.classList.remove('modalSearch');
    },

    doSearch: function(query)
    {
        if (!query.trim().length)
        {
            this.state.results.length = 0;
            this.setState({ totalResults: null });

            return false;
        }

        var self = this;

        $.get(this.articlesSearchURL, { query: query }).then(function(response, status, xhr)
        {
            if (!response.meta.total_results)
            {
                self.state.results.length = 0;
                self.setState({ totalResults: 0 });

                return false;
            }

            self.setState({ totalResults: response.meta.total_results, results: response.results });

        }, function(xhr, status, error)
        {

        });
    }
});

module.exports = FullScreenSearchBox;