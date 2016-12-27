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
        features = response.features
        for f in features
          $.extend(f.properties, {
            'marker-color': '#3ca0d3'
            'description': "<img src='#{@state.imageSrc}' /><p>#{@state.place}</p>"
          })
        L.mapbox.featureLayer().setGeoJSON(response).addTo(@state.map);
      error: (error) =>
        console.error(JSON.parse(error.responseText).message)

    })
    null

