Rails.application.routes.draw do
  devise_for :owners, controllers: { registrations: 'owners/registrations' }
  devise_for :users, controllers: { registrations: 'users/registrations'}
  
  root to: 'home#index'
  get 'search', to: 'home#search'

  get 'lodges_city/:city', to: 'lodges#city', as: :lodges_city

  get 'my_bookings', to: 'bookings#my_bookings', as: :my_bookings

  resources :lodges, only: [:show, :new, :create, :edit, :update, :search] do
    resources :rooms, only: [:show, :new, :create, :edit, :update] do
      resources :special_pricings, only: [:new, :create]
      resources :bookings, only: [:show, :new, :create, :edit, :update]
        get 'availability', to:'bookings#availability', on: :member
        get 'confirmation', to:'bookings#confirmation', on: :member 
        post 'save_booking', to:'bookings#save_booking', on: :member 
    end
  end
end
