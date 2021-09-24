Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # test
  resources :restaurants, only: [ :index, :show ] do
    resources :reviews, only: :create
  end

  resources :chomp_sessions, only: [:new, :create, :edit, :update]
  resources :chomp_sessions, only: :show do
    resources :responses, only: [:create, :show, :update]
    get 'success', to: 'chomp_sessions#success'
  end
  resources :responses, only: [:edit]
end
