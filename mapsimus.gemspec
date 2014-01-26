$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "mapsimus/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
	s.name        = "mapsimus"
	s.version     = Mapsimus::VERSION
	s.authors     = ["Lucas Smolic"]
	s.email       = ["lucas@conceptyard.com"]
	s.homepage    = "http://www.conceptyard.com"
	s.summary     = "Puts Google Maps into your app."
	s.description = "This engine provides Google map functionality in a nice neat view partial"

	s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
	s.test_files = Dir["spec/**/*"]
	#s.test_files = Dir["test/**/*"]

	s.add_dependency "rails", "~> 4.0.2"
	s.add_dependency "coffee-rails"
	s.add_dependency "cache_digests"
	s.add_dependency "actionpack-action_caching"


	s.add_development_dependency 'rspec-rails'
	s.add_development_dependency 'capybara'
	s.add_development_dependency 'factory_girl_rails'
end