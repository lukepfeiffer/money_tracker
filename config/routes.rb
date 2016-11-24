Rails.application.routes.draw do
  root to: 'pages#home'

  resources :users
  resources :sessions
  resources :money_records
  resources :categories

  get "log_out" => "sessions#destroy", :as => "log_out"
  get "log_in" => "sessions#new", :as => "log_in"

end
