require 'net/http'

class Homicide
	include ActiveModel::Model

	attr_accessor :get_murders

	def get_murders
		uri = URI.parse('http://homicide.latimes.com/api/homicide/last-12/')
		result = Net::HTTP.get(uri)
		return JSON.parse(result)
	end
end

