Rails.application.routes.draw do
  root  "home#index"

  devise_for :users, controllers: {
    :sessions      => "users/sessions",
    :registrations => "users/registrations",
    :passwords     => "users/passwords"
  }

  resources :users, only: [:index, :show]
  resources :comments, only: :create
  resources :articles do
    resources :favorite_articles, only: [:create, :destroy]
    
    member do
      patch "release"
      patch "private"
    end
  end
end
