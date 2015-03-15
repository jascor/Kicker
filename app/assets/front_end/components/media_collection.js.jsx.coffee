Router = ReactRouter
Route = Router.Route
DefaultRoute = Router.DefaultRoute
Link = Router.Link
RouteHandler = Route.RouteHandler

MediaCollection = React.createClass(
  propTypes:
    title: React.PropTypes.string
    creatorName: React.PropTypes.string
    description: React.PropTypes.string
    createdAt: React.PropTypes.string
    updatedAt: React.PropTypes.string
    contents: React.PropTypes.array

  handleClick: ->
    console.log 'bro'

  handleMouseOver: ->
    console.log @props.title

  render: ->
    setClasses = React.addons.classSet
    classes = setClasses(
      'mediaCollection': true
      'lightBox': true
      'singleEntry': (if @props.contents and @props.contents.length is 1 then true else false)
    )

    `<div className={classes} onMouseOver={this.handleMouseOver}>
      <h1>Yo</h1>
     </div>`
)

routes =
  `<Route name="media-collection" path="/media-collection/:collectionSlug/content/:collectionPage" handler={MediaCollection}>
  </Route>`

window.MediaCollection = MediaCollection