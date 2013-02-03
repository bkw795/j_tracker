RailsOdyssey::Application.routes.draw do

  root :to => 'users#index'

  resources :users
  resources :games
  resources :responses
  resources :categories
  resources :clues

  resource :session

  match 'login' => 'sessions#new', :as => :login
  match 'logout' => 'sessions#destroy', :as => :logout

end
