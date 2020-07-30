Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'weights#index'
  resource :weights
  resources :users do
    resource :profile ,only: %i[show edit update new create]
  end
  end
