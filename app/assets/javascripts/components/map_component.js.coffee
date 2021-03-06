{ div } = React.DOM
window.Map = class Map extends React.Component
  constructor: (props, context) ->
    super(props, context)
    @state = {
      imagesSrc: props.imagesSrc
      markers: [
        {place: 'Madrid', isocode: 'es', country: 'Spain'},
        {place: 'Dublin', isocode: 'ie', country: 'Ireland'},
        {place: 'Bristol', isocode: 'gb', country: 'United Kingdom'},
        {place: 'Edinburgh', isocode: 'gb', country: 'United Kingdom'},
        {place: 'Oxford', isocode: 'gb', country: 'United Kingdom'},
        {place: 'London', isocode: 'gb', country: 'United Kingdom'},
        {place: 'Cambridge', isocode: 'gb', country: 'United Kingdom'},
        {place: 'Brighton', isocode: 'gb', country: 'United Kingdom'},
        {place: 'Bath', isocode: 'gb', country: 'United Kingdom'},
        {place: 'Nottingham', isocode: 'gb', country: 'United Kingdom'},
        {place: 'Bedford', isocode: 'gb', country: 'United Kingdom'},
        {place: 'Bologna', isocode: 'it', country: 'Italy'},
        {place: 'Locri', isocode: 'it', country: 'Italy'},
        {place: 'Rijeka', isocode: 'hr', country: 'Croatia'},
        {place: 'Opatija', isocode: 'hr', country: 'Croatia', latlng: ['45.3376197', '14.3051960']},
        {place: 'Lyon', isocode: 'fr', country: 'France'},
        {place: 'Geneva', isocode: 'ch', country: 'Switzerland'},
        {place: 'Liverpool', isocode: 'gb', country: 'United Kingdom'},
        {place: 'Cardiff', isocode: 'gb', country: 'United Kingom'},
        {place: 'Turin', isocode: 'it', country: 'Italy'},
        {place: 'Malaga', isocode: 'es', country: 'Spain'},
        {place: 'Paris', isocode: 'fr', country: 'France'},
        {place: 'Brussels', isocode: 'be', country: 'Belgium'},
        {place: 'Rotterdam', isocode: 'nl', country: 'Netherlands'},
        {place: 'Amsterdam', isocode: 'nl', country: 'Netherlands'},
        {place: 'Florence', isocode: 'it', country: 'Italy'}
      ]
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
    for m in @state.markers
      if m.latlng
        @addLatLngMarker(m.place, m.latlng)
      else
        @addMarker(m.place, m.isocode, m.country)

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

  addRightClickListener: () ->
    @state.map.on('contextmenu', (e) ->
      React.createElement(LatLngMarker,
        {
          key: "marker"
          map: @state.map
          place: ''
          latLng: [e.latlng.lat, e.latlng.lng]
          imageSrc: ''
        }
      )
    )
