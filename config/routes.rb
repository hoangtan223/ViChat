Rails.application.routes.draw do

  get 'relationships/create'

  get 'messages/new'

  get 'users/new'

  get '/login' => 'sessions#new'

  delete 'logout' => 'sessions#destroy'

  root 'home#index'

  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :messages
  resources :relationships

  post 'accept_request' => 'relationships#accept_request'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
