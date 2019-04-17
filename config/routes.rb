Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root to: 'bookings#index'

  resources :bookings do
    collection do
      get :list
    end
    member do
      get :passenger
      post :confirm
    end
  end
end
