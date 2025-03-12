Rails.application.routes.draw do
  root to: "application#check_health"
  resources :todos
  resources :users
  post "/login", to: "authentication#login"
end
