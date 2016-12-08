Rails.application.routes.draw do
  root to: 'pages#home'

  resources :users
  resources :sessions
  resources :money_records
  resources :categories do
    collection do
      get 'archived'
      get 'unarchive'
      get 'example'
      delete 'unarchive'
    end
  end


  get '/contact', to: 'pages#contact'
  get "log_out" => "sessions#destroy", :as => "log_out"
  get "log_in" => "sessions#new", :as => "log_in"

end
