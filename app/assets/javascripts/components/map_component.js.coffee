{ div } = React.DOM
window.Map = class Map extends React.Component
  constructor: (props, context) ->
    super(props, context)
    @state = {
      imagesSrc: props.imagesSrc
    }
    L.mapbox.accessToken =
      'pk.eyJ1IjoibGV2aWF0aGFuczE3IiwiYSI6ImNpeDJhNjIwcTAwMDYyeW8zNDEzZ216aG4ifQ.Nspo1rr2U1KLH1LL-8IZvA'

  render: ->
    div(
      { className: 'map-container' }
      div({ id: 'map' })
      @renderMarkers() if @state.map
    )

  componentDidMount: ->
    map = L.mapbox.map('map', 'mapbox.streets').setView([47, 15], 4)
    @setState({map: map })

  renderMarkers: ->
    [
      @addMarker('Madrid', 'es', 'Spain')
      @addMarker('Dublin', 'ie', 'Ireland')
      @addMarker('Bristol', 'gb', 'United Kingdom')
      @addMarker('Edinburgh', 'gb', 'United Kingdom')
      @addMarker('Oxford', 'gb', 'United Kingdom')
      @addMarker('London', 'gb', 'United Kingdom')
      @addMarker('Cambridge', 'gb', 'United Kingdom')
      @addMarker('Brighton', 'gb', 'United Kingdom')
      @addMarker('Bologna', 'it', 'Italy')
      @addMarker('Locri', 'it', 'Italy')
      @addMarker('Bassano del Grappa', 'it', 'Italy', 'bassano')
      @addMarker('Rijeka', 'hr', 'Croatia')
      @addMarker('Opatija', 'hr', 'Croatia')
      @addMarker('Lyon', 'fr', 'France')
    ]

  addMarker: (place, isoCode, country, extraKey) ->
    placeDown = place.toLowerCase()
    key = extraKey || placeDown
    React.createElement(Marker,
      {
        key: "#{key}-marker"
        map: @state.map
        place: place
        isoCode: isoCode
        country: country
        imageSrc: @state.imagesSrc[key]
      }
    )
