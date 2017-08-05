Rails.application.routes.draw do
  root to: 'pages#home'

  resources :users do
    collection do
      get :confirm_email
    end
  end
  resources :sessions
  resources :money_records
  resources :paychecks
  resources :sessions_path, only: [:new]
  resources :categories do
    collection do
      get 'archived'
      delete 'unarchive'
    end
  end


  get '/contact', to: 'pages#contact'
  get '/about', to: 'pages#about'

  get "log_out" => "sessions#destroy", :as => "log_out"
  get "log_in" => "sessions#new", :as => "log_in"
  get '/contact', to: "pages#contact"
  post '/email_admin', to: "pages#email_admin"

end
