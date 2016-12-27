window.Marker = class Marker extends React.Component
  constructor: (props, context) ->
    super(props, context)
    @state = {
      map: props.map
      place: props.place
      isoCode: props.isoCode
      country: props.country
      imageSrc: props.imageSrc
      baseUrl: "https://api.mapbox.com/geocoding/v5/mapbox.places"
      cambridgeCoords: ['52.203394', '0.131493']
    }

  render: ->
    $.ajax({
      url:
        """
          #{@state.baseUrl}/#{@state.place}%20centre.json?access_token=#{L.mapbox.accessToken}
          &country=#{@state.isoCode}&limit=1
        """
      type: 'get'
      dataType: 'json'
      success: (response) =>
        f = response.features[0]
        $.extend(f.properties, {
          'marker-color': '#e00000'
          'description': "<img src='#{@state.imageSrc}' /><p>#{@state.place}</p>"
        })
        layer = L.mapbox.featureLayer()
        layer.setGeoJSON(response).addTo(@state.map)
        layer.bindPopup(f.properties.description, {closeButton: false})
        layer.on('mouseover', -> layer.openPopup())
        layer.on('mouseout', -> layer.closePopup())
        @addLine(f.geometry.coordinates)

      error: (error) =>
        console.error(JSON.parse(error.responseText).message)

    })
    null

  addLine: (coordinates) ->
    polyline = L.polyline([]).addTo(@state.map)
    polyline.addLatLng(
      L.latLng(coordinates.reverse())
    )
    polyline.addLatLng(
      L.latLng(@state.cambridgeCoords)
    )
