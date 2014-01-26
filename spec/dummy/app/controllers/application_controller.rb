class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

	def home
		@map = Map.new
		@map.title = "MurderWood - homicides in 2013"
		@map.data_url = 'http://0.0.0.0:3000/data/homicide'
		@map.icon_url = 'http://i.imgur.com/gUNZQhY.png'
		@map.center_latitude = 34.05223
		@map.center_longitude = -118.24368
		@map.zoom_level = 10
		@map.pan_control = true
		@map.draggable = true
		@map.street_view_control = false
		@map.zoom_control = true
		@map.scroll_wheel = true
		@map.map_type_control = false
		@map.cluster_icon_url_small = 'http://i.imgur.com/NWPj22A.png'
		@map.cluster_icon_url_medium = 'http://i.imgur.com/NWPj22A.png'
		@map.cluster_icon_url_large = 'http://i.imgur.com/NWPj22A.png'
		raise("Invalid Map parameters") unless @map.valid?
	end
end
