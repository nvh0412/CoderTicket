Rails.application.routes.draw do
  devise_for :users
  root 'events#index'

  resources :events do
    resources :tickets
  end

  resources :orders, only: [:index, :new, :create]

end
