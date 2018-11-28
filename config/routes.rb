Rails.application.routes.draw do
  get 'users/index'

  get 'home/index'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"

  resources :roles
  resources :sims, except: [:show]
  resources :sim_targets, except: [:show]
  resources :users, only: [:index] do
    put 'status', on: :member
  end
end
