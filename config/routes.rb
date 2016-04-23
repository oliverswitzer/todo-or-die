TodoOrDie::Application.routes.draw do
  root to: 'home#index'
  resources :goals

  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }
end
