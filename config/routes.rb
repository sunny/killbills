KillBills::Application.routes.draw do

  # Admin
  ActiveAdmin.routes(self)
  devise_for :admin_users, ActiveAdmin::Devise.config

  scope "/(:locale)", locale: /en|fr/ do
    devise_for :users, controllers: { sessions: "sessions" }

    resources :friends
    resources :bills
    resource :options, only: [:edit, :update]
  end

  get '/:locale', to: 'pages#index', locale: /en|fr/, as: :home
  root to: 'pages#index'

end
