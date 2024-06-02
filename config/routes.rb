Rails.application.routes.draw do
  get 'posts/index'
  devise_for :users
  resources :users, only: [:show] do
    #add follow/unfollow for profile
    resource :profile, only: [:show, :edit, :update] do
      member do
        post 'follow'
        delete 'unfollow'
      end
    end
  end

  resources :posts do
    resources :likes
    resources :comments
  end
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "posts#index"
end
