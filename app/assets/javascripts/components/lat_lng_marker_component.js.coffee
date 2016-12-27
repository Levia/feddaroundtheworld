window.LatLngMarker = class LatLngMarker extends React.Component
  constructor: (props, context) ->
    super(props, context)
    @state = {
      map: props.map
      place: props.place
      latLng: props.latLng
      imageSrc: props.imageSrc
    }

  render: ->
    feature = {
      type: "Feature",
      center: @state.latLng,
      properties: {
        id: "#{@state.place}_marker",
        title: @state.place,
        landmark: false,
        maki: "cinema"
        description: "<img src='#{@state.imageSrc}' /><p>#{@state.place}</p>",
        "marker-color": '#e00000',
      },
      geometry: {
        coordinates: @state.latLng.reverse(),
        type: "Point"
      },
      id: "#{@state.place}_feature"
    }
    layer = L.mapbox.featureLayer()
    layer.setGeoJSON(feature).addTo(@state.map)
    layer.bindPopup(feature.properties.description, {closeButton: false})
    layer.on('mouseover', -> layer.openPopup())
    layer.on('mouseout', -> layer.closePopup())
    null

