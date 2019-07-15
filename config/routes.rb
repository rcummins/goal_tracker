Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resource :session, only: [:new, :create, :destroy]

  resources :users, only: [:index, :show, :new, :create] do
    resources :goals, only: [:new]
    resources :user_comments, only: [:new]
  end

  resources :goals, only: [:create, :edit, :show, :update, :destroy] do
    resources :goal_comments, only: [:new]
  end

  resources :user_comments, only: [:create]

  resources :goal_comments, only: [:create]

  root to: 'users#index'
end
