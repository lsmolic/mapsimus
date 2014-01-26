Rails.application.routes.draw do
	get 'map', to: 'map#index'
	get 'data/homicide', to: 'data#homicide', format: :json
end
