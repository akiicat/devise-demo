Rails.application.routes.draw do
  devise_for :users, controllers: { confirmations: "confirmations", omniauth_callbacks: "users/omniauth_callbacks" }
  resources :books
  root to: "books#index"


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
