{ div } = React.DOM
window.MapComponent = class MapComponent extends React.Component
  constructor: (props, context) ->
    L.mapbox.accessToken =
      'pk.eyJ1IjoibGV2aWF0aGFuczE3IiwiYSI6ImNpeDJhNjIwcTAwMDYyeW8zNDEzZ216aG4ifQ.Nspo1rr2U1KLH1LL-8IZvA'

  render: ->
    div({ id: 'map' })
    @renderMarkers() if @state.map

  componentDidMount: ->
    map = L.mapbox.map('map', 'mapbox.streets').setView([40, -74.50], 9)
    @setState({map: map })
