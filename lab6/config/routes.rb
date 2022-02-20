Rails.application.routes.draw do
  root 'reports#index'

  resources :reports, only: [:index, :new, :create, :edit, :update, :destroy]
  resources :users, only: [:new, :create]
end
