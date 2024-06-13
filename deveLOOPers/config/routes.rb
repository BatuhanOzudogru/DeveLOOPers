Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root "welcome#index"

  get 'welcome/index'

  resources :articles do
    resources :comments, only: [:create, :destroy] do
      member do
        put 'approve'
        delete 'reject'
      end
    end

    member do
      post 'add_vote'
      post 'remove_vote'
    end

    collection do
      get 'search'
    end
  end

  
  get '/users/:nickname', to: 'users#show', as: 'user_profile'
  get '/users/:nickname/edit', to: 'users#edit', as: 'edit_user_profile'
  patch '/users/:nickname', to: 'users#update'
end
