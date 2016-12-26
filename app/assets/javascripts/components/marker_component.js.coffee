window.Marker = class Marker extends React.Component
  constructor: (props, context) ->
    super(props, context)
    @state = {
      map: props.map
      place: props.place
      country: props.country
      base_url: "https://api.mapbox.com/geocoding/v5/mapbox.places"
    }

  render: ->
    $.ajax({
      url:
        """
          #{@state.base_url}/#{@state.place}.json?access_token=#{L.mapbox.accessToken}
          &country=#{@state.country}
        """
      type: 'get'
      dataType: 'json'
      success: (response) =>
        L.mapbox.featureLayer().setGeoJSON(response).addTo(@state.map);

    })
    null

