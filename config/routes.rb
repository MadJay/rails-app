Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
root "engarde#index"
resources :engarde
resources :miseries_misfortunes
end
