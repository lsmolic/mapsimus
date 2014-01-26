Rails.application.routes.draw do

  mount Mapsimus::Engine => "/"

	root :to => "application#home"
end
