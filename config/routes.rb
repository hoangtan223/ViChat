Rails.application.routes.draw do

  get 'messages/new'

  get 'users/new'

  get '/login' => 'sessions#new'

  delete 'logout' => 'sessions#destroy'

  root 'home#index'

  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :messages
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
