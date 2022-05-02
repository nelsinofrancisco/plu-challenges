Rails.application.routes.draw do
  resources :properties, only: %i[index new show]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "properties#index"
end
