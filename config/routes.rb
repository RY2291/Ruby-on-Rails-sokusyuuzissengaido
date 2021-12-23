Rails.application.routes.draw do
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "session#destroy"
  get 'sessions/new'
  namespace :admin do
    resources :users
  end
  resources :tasks
  root to: "tasks#index"
end
