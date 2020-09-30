Rails.application.routes.draw do
  root to: "rates#show"
  get '/u', to: 'rates#show'

  mount ActionCable.server => '/cable'
end
