Rails.application.routes.draw do
  #get 'csv_imports/new'
  #get 'csv_imports/create'
  root 'csv_imports#new'
  resources :csv_imports, only: [:new, :create]
  resources :people, only: [:index]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
