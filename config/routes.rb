Rails.application.routes.draw do
  devise_for :owners
  devise_for :users
  
  root to: 'home#index'

  resources :lodges, only: [:show, :new, :create, :edit, :update]
end
