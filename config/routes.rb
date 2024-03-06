require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users
  resources :books, only: %i[index show new create edit update] do
    post :reserve, on: :member
  end
  mount Sidekiq::Web => "/sidekiq" # mount Sidekiq::Web in your Rails app
  root "books#index"
end
