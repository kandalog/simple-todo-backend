Rails.application.routes.draw do
  resources :todos
  resources :users
  post '/login', to: 'authentication#login'
end
