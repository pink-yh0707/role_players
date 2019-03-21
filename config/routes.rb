Rails.application.routes.draw do
  root  "home#index"

  devise_for :users, controllers: {
    sessions:           "users/sessions",
    registrations:      "users/registrations",
    passwords:          "users/passwords",
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  resources :users, only: [:index, :show] do
    resources :relationships, only: [:create, :destroy]

    member do
      get :following, :followers, :favorite_order, :user_favorite_articles
    end
  end

  resources :comments, only: :create
  resources :articles do
    resources :favorite_articles, only: [:create, :destroy]

    get :favorite_order, on: :collection

    member do
      patch :release, :private
    end
  end
end
