Rails.application.routes.draw do
  devise_for :owners, controllers: { registrations: 'owners/registrations' }
  devise_for :users
  
  root to: 'home#index'

  resources :lodges, only: [:show, :new, :create, :edit, :update] do
    resources :rooms, only: [:show, :new, :create, :edit, :update] do
      resources :special_pricings, only: [:new, :create]
    end
  end
end
