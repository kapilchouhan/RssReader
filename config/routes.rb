require 'sidekiq/web'

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :feeds
  resources :readers, only: :index

  root 'feeds#index' 

  mount Sidekiq::Web => '/sidekiq'
end
