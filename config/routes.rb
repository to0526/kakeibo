Rails.application.routes.draw do
  resources :reservations
  defaults format: :json do
    namespace :api do
      resources :users, only: [:index]
      resources :payment_classifications, only: [:index]
      resources :payment_methods, only: [:index]
      resources :selectable_year_months, only: [:index]
    end
  end
  resources :incomes, only: [:new, :create, :edit, :update, :destroy]
  resources :items, only: [:index]
  root to: "items#index"
  resources :payments, only: [:new, :create, :edit, :update, :destroy]
  resources :payment_classifications, only: [:index, :new, :create, :edit, :update, :destroy]
  resources :payment_methods, only: [:index, :new, :create, :edit, :update, :destroy]
  resources :users, only: [:index, :new, :create, :edit, :update, :destroy]
  resources :user_sessions, only: [:create]
  get 'login' => 'user_sessions#new', :as => :login
  post 'logout' => 'user_sessions#destroy', :as => :logout
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
