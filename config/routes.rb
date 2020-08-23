Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'weights#show'
  resources :weights

  resources :users do
    resource :profile ,only: %i[show edit update new create]
    resources :meals do
      resource :favorite, only: [:create, :destroy]
    end
  end
end
