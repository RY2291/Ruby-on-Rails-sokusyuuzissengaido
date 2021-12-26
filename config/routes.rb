Rails.application.routes.draw do
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "session#destroy"
  get 'sessions/new'
  namespace :admin do
    resources :users
  end
  resources :tasks do
    post :confirm, action: :confirm_new, on: :new
    post :import, action: :import, on: :collection
  end
  root to: "tasks#index"
end
