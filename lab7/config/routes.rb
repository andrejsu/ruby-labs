Rails.application.routes.draw do
  root 'reports#index'

  resources :reports, only: [:index, :new, :create, :edit, :update, :destroy]

  devise_for :users, controllers: { registrations: 'users/registrations' }
end
