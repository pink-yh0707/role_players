Rails.application.routes.draw do
  root  "home#index"

  devise_for :users, controllers: {
    :sessions      => "users/sessions",
    :registrations => "users/registrations",
    :passwords     => "users/passwords"
  }

  resources :users, only: [:index, :show]
  resources :articles do
    member do
      patch "release"
      patch "private"
    end
  end
end
