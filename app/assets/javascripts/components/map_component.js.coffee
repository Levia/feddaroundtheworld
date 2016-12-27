{ div } = React.DOM
window.Map = class Map extends React.Component
  constructor: (props, context) ->
    super(props, context)
    @state = {
      imagesSrc: props.imagesSrc
    }
    L.mapbox.accessToken = props.mapboxToken

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
      @addMarker('Bath', 'gb', 'United Kingdom')
      @addMarker('Bologna', 'it', 'Italy')
      @addMarker('Locri', 'it', 'Italy')
      #@addMarker('Bassano del Grappa', 'it', 'Italy', 'bassano')
      @addMarker('Rijeka', 'hr', 'Croatia')
      @addLatLngMarker('Opatija', ['45.3376197', '14.3051960'])
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

  addLatLngMarker: (place, latLng) ->
    key = place.toLowerCase()
    React.createElement(LatLngMarker,
      {
        key: "#{key}-marker"
        map: @state.map
        place: place
        latLng: latLng
        imageSrc: @state.imagesSrc[key]
      }
    )
