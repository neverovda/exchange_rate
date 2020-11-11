Rails.application.routes.draw do
  root to: 'rates#show'

  get '/u', to: 'rates#show'
  get '/admin', to: 'admin_rates#new'
  resources :admin_rates, only: :create

  mount ActionCable.server => '/cable'
end
