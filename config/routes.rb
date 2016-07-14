Rails.application.routes.draw do

  get 'users/new'

  get '/login' => 'sessions#new'

  delete 'logout' => 'sessions#destroy'

  root 'home#index'

  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
