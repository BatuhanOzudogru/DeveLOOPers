Rails.application.routes.draw do
  devise_for :users
  get 'welcome/index'
  resources :articles do
    member do
      post 'add_vote'
      post 'remove_vote'
    end
    resources :comments, only: [:create, :destroy]
  end

  get '/users/:id', to: 'users#show', as: 'user_profile'
  root "welcome#index"
end
