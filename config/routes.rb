Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  root 'events#index'

  resources :events do
    resources :tickets
  end

  resources :venues

  get '/user/events', to: 'events#event_of_user', as: 'user_event'

end
