Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resource :session, only: [:new, :create, :destroy]

  resources :users, only: [:index, :show, :new, :create] do
    resources :goals, only: [:new]
  end

  resources :goals, only: [:create, :edit, :show, :update, :destroy]

  resources :comments, only: [:create]

  root to: 'users#index'
end
