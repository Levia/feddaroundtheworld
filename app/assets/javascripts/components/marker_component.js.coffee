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
          'marker-color': '#3ca0d3'
          'description': "<img src='#{@state.imageSrc}' /><p>#{@state.place}</p>"
        })
        layer = L.mapbox.featureLayer()
        layer.setGeoJSON(response).addTo(@state.map)
        layer.bindPopup(f.properties.description, {closeButton: false})
        layer.on('mouseover', -> layer.openPopup())
        layer.on('mouseout', -> layer.closePopup())

      error: (error) =>
        console.error(JSON.parse(error.responseText).message)

    })
    null

