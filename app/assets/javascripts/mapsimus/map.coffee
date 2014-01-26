# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.

jQuery ($) ->

  # Make the following global variables
  map = null
  markers = null
  plotted_markers = null
  data_url = null
  icon_url = null
  center_latitude = null
  center_longitude = null
  zoom_level = null
  pan_control = null
  draggable = null
  street_view_control = null
  zoom_control = null
  scroll_wheel = null
  map_type_control = null
  cluster_icon_url_small = null
  cluster_icon_url_medium = null
  cluster_icon_url_large = null


  init = () ->
    #get options passed from server
    parseDataOptions()

    # Setup map options
    mapOptions =
      center: new google.maps.LatLng(center_latitude, center_longitude)
      zoom: 10
      panControl : pan_control
      draggable : draggable
      streetViewControl : street_view_control
      zoomControl : zoom_control
      scrollWheel : scroll_wheel
      mapTypeControl : map_type_control
      mapTypeId: google.maps.MapTypeId.ROADMAP
      mapTypeControlOptions:
        mapTypeIds: [google.maps.MapTypeId.ROADMAP, 'map_style']
    infowindow = new google.maps.InfoWindow

    # Create the map with above options in div
    map = new google.maps.Map(document.getElementById("mf-map"), mapOptions)

    # Create the actual markers for the looped places
    plotMarker = (marker) ->

      # Create markers for of the types assigned above in getTypes function
      plotted_marker = new google.maps.Marker
        map: map
        position: marker.latlng
        icon:  icon_url

      plotted_markers.push(plotted_marker)

      # Create a click listener that shows a info window with places name
      google.maps.event.addListener plotted_marker, 'click', ->
        infowindow.setContent(marker.description)
        infowindow.open(map,plotted_marker)


    refreshMurders = () ->
      clearPlottedMarkers()

      $.ajax
        url: data_url
        type: 'GET'
        datatype: "json"
        contentType: "application/json; charset=utf-8"
        error: (xhr, status, error) ->
          alert(error)
        success: (response) ->
          parseData(response)

    clearPlottedMarkers = () ->
      # if markers array is null, initialize and return
      if plotted_markers == null
        plotted_markers = []
        return

      #otherwise, clear it out, and empty the array
      for index, attrs of plotted_markers
        plotted_markers[index].setMap(null)
      plotted_markers = []

    parseData = (data) ->
      #markers is essentially a local cache, we just clear it if we are getting new data
      markers = []

      #just before we plot the new markers, after we have the data, clear the map
      clearPlottedMarkers()

      $.each data, (i, obj) ->
        latlng = new google.maps.LatLng(obj.coordinates[1], obj.coordinates[0])
        marker = new MapMarker(latlng, obj.description)
        markers.push(marker)
        plotMarker(marker)

      #set the styles for clustering. Basically we just use the same Icon here.
      styles = [
        url: cluster_icon_url_small
        height: 32
        width: 33
        anchor: [12, 0]
        textColor: "#ff00ff"
        textSize: 10
      ,
        url: cluster_icon_url_medium
        height: 32
        width: 33
        anchor: [12, 0]
        textColor: "#ff00ff"
        textSize: 10
      ,
        url: cluster_icon_url_large
        height: 32
        width: 33
        anchor: [12, 0]
        textColor: "#ff00ff"
        textSize: 10
      ]

      options_markerclusterer =
        gridSize: 20,
        maxZoom: 18,
        zoomOnClick: false
        styles: styles

      markerCluster = new MarkerClusterer(map, plotted_markers, options_markerclusterer)

    refreshMurders()

  parseDataOptions = () ->
    #get data-options
    options = $("#mf-map").data( "options" )
    center_latitude = options.center_latitude
    center_longitude = options.center_longitude
    zoom_level = parseInt(options.zoom_level)
    pan_control = options.pan_control
    draggable = options.draggable
    street_view_control = options.street_view_control
    zoom_control = options.zoom_control
    scroll_wheel = options.scroll_wheel
    map_type_control = options.map_type_control
    data_url = options.data_url
    icon_url = options.icon_url
    cluster_icon_url_small = options.cluster_icon_url_small
    cluster_icon_url_medium = options.cluster_icon_url_medium
    cluster_icon_url_large = options.cluster_icon_url_large

  init()

