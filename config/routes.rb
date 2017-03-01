TodoOrDie::Application.routes.draw do
  root to: 'home#index'
  resources :goals do
    get '/countdown', action: 'countdown'
  end
  resources :friends, only: :index

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks'}
end
