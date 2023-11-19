Rails.application.routes.draw do
  devise_for :owners, controllers: { registrations: 'owners/registrations' }
  devise_for :users, controllers: { registrations: 'users/registrations'}
  
  root to: 'home#index'
  get 'search', to: 'home#search'

  get 'lodges_city/:city', to: 'lodges#city', as: :lodges_city

  get 'my_bookings', to: 'bookings#my_bookings', as: :my_bookings
  post 'bookings/:id/cancel', to: 'bookings#cancel_booking', as: :cancel_booking

  get 'lodge_bookings', to: 'bookings#lodge_bookings', as: :lodge_bookings
  #post 'bookings/:id/cancel', to: 'bookings#cancel_booking', as: :cancel_booking
  
  resources :lodges, only: [:show, :new, :create, :edit, :update, :search] do
    resources :rooms, only: [:show, :new, :create, :edit, :update] do
      resources :special_pricings, only: [:new, :create]
      resources :bookings, only: [:new, :create, :edit, :update]
        get 'availability', to:'bookings#availability', on: :member
        get 'confirmation', to:'bookings#confirmation', on: :member 
        post 'save_booking', to:'bookings#save_booking', on: :member 
        #post 'cancel_booking', to:'bookings#cancel_booking', on: :member
    end
  end

  resources :bookings, only: [:index, :show] do
    get 'active', on: :collection
  end

end
