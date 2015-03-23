/*
 * @todo Animate moving through slides
 */

var AnimateMixin = require('react-animate');

window.InlineSlideshow = React.createClass({
    mixins: [AnimateMixin],

    propTypes: {
        title: React.PropTypes.string,
        totalSlides: React.PropTypes.number,
        slides: React.PropTypes.array
    },

    getDefaultProps: function()
    {

    },

    getInitialState: function()
    {
        return {
            currentSlide: 1
        }
    },

    fadeIn: function()
    {
        this.animate(
            'transition-next-slide',
            { opacity: 0 },
            { opacity: 1 },
            500,
            { easing: 'linear' }
        );
    },

    componentDidMount: function()
    {
        if (this.canAdvanceSlide())
        {
            // Having issues with preloadNextImage() function on first load
            var image = new Image();
            image.src = this.props.slides[1].link;
        }
    },

    render: function()
    {
        var slideContentsClasses = this.props.title ? 'contents' : 'contents withoutTitle';

        return (
            <figure className="slideshow mediaCollection inline">
                {this.props.title &&
                    <header>
                        <h4 className="title">{this.props.title}</h4>
                    </header>
                }
                <div className={slideContentsClasses}>
                    <div className="slideContainer" style={this.getAnimatedStyle('transition-next-slide')}>
                        <div className="openFullScreenSlideshow"></div>
                        <img className="currentSlide" src={this.props.slides[this.state.currentSlide - 1].link} />
                        <nav className="leftClick" title="Previous Slide"  onClick={this.backToPreviousSlide}></nav>
                        <nav className="rightClick" title="Next Slide" onClick={this.advanceToNextSlide}></nav>
                    </div>
                </div>
                <div className="meta">
                    <p className="caption">
                        {this.props.slides[this.state.currentSlide - 1].caption}
                    </p>
                    <span className="credit">{this.props.slides[this.state.currentSlide - 1].credit}</span>
                </div>
                <nav className="slideNav">
                    <span className="slideCounter">
                        <span className="currentSlidePage">{this.state.currentSlide} </span>
                        of {this.props.totalSlides}
                    </span>
                    <div className="previousSlide" title="Previous Slide" onClick={this.backToPreviousSlide}></div>
                    <div className="nextSlide" title="Next Slide" onClick={this.advanceToNextSlide}></div>
                </nav>
            </figure>
        );
    },

    canAdvanceSlide: function()
    {
        return this.state.currentSlide < this.props.totalSlides;
    },

    canGoBackToPreviousSlide: function()
    {
        return this.state.currentSlide > 1;
    },

    advanceToNextSlide: function()
    {
        this.fadeIn();

        if (this.canAdvanceSlide())
        {
            this.setState({
                currentSlide: this.state.currentSlide + 1
            });
        }
        else
        {
            this.setState({
                currentSlide: 1
            });
        }

        this.preloadNextImage();
    },

    backToPreviousSlide: function()
    {
        this.fadeIn();

        if (this.canGoBackToPreviousSlide())
        {
            this.setState({
                currentSlide: this.state.currentSlide - 1
            });
        }
        else
        {
            this.setState({
                currentSlide: this.props.totalSlides
            });
        }

        this.preloadNextImage();
    },

    preloadNextImage: function()
    {
        if (this.canAdvanceSlide())
        {
            var image = new Image();

            image.src = this.props.slides[this.state.currentSlide + 1].link;
        }
    }
});

module.exports = InlineSlideshow;