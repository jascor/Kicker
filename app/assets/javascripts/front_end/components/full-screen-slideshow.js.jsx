window.FullScreenSlideshow = React.createClass({
    propTypes: {
        title: React.PropTypes.string,
        currentSlide: React.PropTypes.number,
        totalSlides: React.PropTypes.number,
        slides: React.PropTypes.array
    },

    getInitialState: function()
    {
        return {
            currentSlide: 1,
        }
    },

    render: function()
    {

    }
});