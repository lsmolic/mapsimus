class DataController < ApplicationController
	caches_action :homicide, :expires_in => 1.hour

	def homicide

		homicide = Homicide.new
		#todo: add params to narrow search
		murder_json = homicide.get_murders

		murders = []

		murder_json['geojson']['features'].each do |feature|
			props = feature['properties']
			geometry = feature['geometry']

			name = props['n'] || "unknown"
			race = props['r'] || "unspecified"
			gender = props['g'] || "person"
			cause = props['c'] || "unknown cause"
			neighborhood = props['nh'] || "unknown"

			coordinates = geometry['coordinates']

			description ="<h1>#{name}</h1><p>#{gender} of #{race} race killed by #{cause} in the #{neighborhood} neighborhood</p>"

			murder = {
			    :coordinates => coordinates,
			    :description => description
			}

			murders << murder
		end


		render :json => murders.as_json

	end
end