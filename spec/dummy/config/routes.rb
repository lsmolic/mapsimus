Rails.application.routes.draw do
	root :to => "application#home"
  get 'data/homicide', to: 'data#homicide', format: :json
end
