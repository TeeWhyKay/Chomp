Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # test
  resources :restaurants, only: %i[index show] do
    member do
      post 'toggle_favorite'
    end
    resources :reviews, only: %i[create update]
  end

  resources :chomp_sessions, only: %i[new create edit update]
  resources :chomp_sessions, only: :show do
    resources :responses, only: %i[create show update]
    get 'success', to: 'chomp_sessions#success'
  end

  resources :responses, only: [:edit]

  get 'chomp_sessions/:chomp_session_id/result', to: 'chomp_sessions#result', as: 'chomp_session_result'

  post '/reverse_geocode', to: 'responses#reverse_geocode', defaults: { format: 'json' }

  # Sidekiq Web UI, only for admins.
  require "sidekiq/web"
  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
end
