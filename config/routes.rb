Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  devise_scope  :user do
    get 'users/sign_out' => 'devise/sessions#destroy'
  end
  
  # Defines the root path route ("/")
  # root "articles#index"
  
  root 'users#index'
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :new, :create, :show, :destroy] do
      resources :comments, only: [:new, :create, :destroy]
      resources :likes, only: [:new, :create]
    end
  end
end
