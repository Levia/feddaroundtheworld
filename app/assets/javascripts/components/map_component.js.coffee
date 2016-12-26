{ div } = React.DOM
window.Map = class Map extends React.Component
  constructor: (props, context) ->
    super(props, context)
    @state = {}
    L.mapbox.accessToken =
      'pk.eyJ1IjoibGV2aWF0aGFuczE3IiwiYSI6ImNpeDJhNjIwcTAwMDYyeW8zNDEzZ216aG4ifQ.Nspo1rr2U1KLH1LL-8IZvA'

  render: ->
    div(
      { className: 'map-container' }
      div({ id: 'map' })
      @renderMarkers() if @state.map
    )

  componentDidMount: ->
    map = L.mapbox.map('map', 'mapbox.streets').setView([40, -74.50], 9)
    @setState({map: map })

  renderMarkers: ->
    React.createElement(Marker,
      {
        key: 'opatija-marker'
        map: @state.map
        place: 'Opatija'
        country: 'hr'
      }
    )


