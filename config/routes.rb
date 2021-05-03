Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'static#index'
  resources :stacks do
    resources :cards
  end

  resource :users, only: [:create]
  post "/login", to: "auth#login"

  get "/auto_login", to: "auth#auto_login"

  get "/user_is_authed", to: "auth#user_is_authed"
end
