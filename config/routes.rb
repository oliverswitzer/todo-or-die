TodoOrDie::Application.routes.draw do
  root to: 'home#index'
  resources :goals
  resources :friends, only: :index

  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }
end
