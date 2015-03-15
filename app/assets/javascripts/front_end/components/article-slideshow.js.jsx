var ArticleSlideshow = React.createClass({
    propTypes: {
        title: React.PropTypes.string,
        currentPage: React.PropTypes.number,
        totalPages: React.PropTypes.number,
        slides: React.PropTypes.array
    },

    getDefaultProps: function()
    {
        return {
            currentPage: 1
        }
    },

    render: function()
    {
        return (
            <figure class="slideshow mediaCollection inline">
                <header>
                    <h4 class="title">{this.props.title}</h4>
                </header>
                <div class="contents">
                    <div class="imageContainer">
                        <img class="currentSlide" src={this.props.slides[currentPage].link}>
                        <nav class="leftClick">
                        <nav class="rightClick">
                    </div>
                </div>
                <div class="meta">
                    <p class="caption">
                        {this.props.slides[currentPage].caption}
                        <span class="credit">{this.props.slides[currentPage].credit}</span>
                    </p>
                </div>
                <nav class="slideNav">
                    <span class="slideCounter">
                        <span class="currentSlidePage">{this.props.currentPage}</span>
                        /{this.props.totalPages}
                    </span>
                    <div class="previousSlide"></div>
                    <div class="nextSlide"></div>
                </nav>
            </figure>
        );
    }
});