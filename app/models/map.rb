class Map
	include ActiveModel::Model

	validates_presence_of :show_title, :data_url, :icon_url,
	                      :cluster_icon_url_small, :cluster_icon_url_medium, :cluster_icon_url_large
	validates_inclusion_of :show_title, in: [true, false]
	validates :data_url, :url => true

	attr_accessor :title, :show_title, :data_url, :icon_url,
	              :cluster_icon_url_small, :cluster_icon_url_medium, :cluster_icon_url_large,
	              :center_latitude, :center_longitude, :zoom_level, :pan_control, :draggable,
	              :street_view_control, :zoom_control, :scroll_wheel, :map_type_control

	def initialize(attributes={})
		super
		set_defaults
	end

	def show_title?
		@show_title
	end

	def options
		return {
				:data_url => data_url,
		    :icon_url => icon_url,
		    :cluster_icon_url_small => cluster_icon_url_small,
		    :cluster_icon_url_medium => cluster_icon_url_medium,
		    :cluster_icon_url_large => cluster_icon_url_large,
		    :center_latitude => center_latitude,
		    :center_longitude => center_longitude,
		    :zoom_level => zoom_level,
		    :pan_control => pan_control,
		    :draggable => draggable,
		    :street_view_control => street_view_control,
		    :zoom_control => zoom_control,
		    :scroll_wheel => scroll_wheel,
		    :map_type_control => map_type_control
		}
	end

	private
	def set_defaults
		@show_title = true
	end
end

