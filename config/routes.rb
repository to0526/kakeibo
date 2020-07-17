Rails.application.routes.draw do
  resources :payments
  root to: "users#index"
  resources :payment_classifications
  resources :payment_methods
  resources :users
  resources :user_sessions, only: [:create]
  get 'login' => 'user_sessions#new', :as => :login
  post 'logout' => 'user_sessions#destroy', :as => :logout
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
