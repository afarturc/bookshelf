require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users
  resources :books do
    post :reserve, on: :member
  end
  resources :reservations, only: %i[index update show]
  resources :company_reservations, only: %i[index], path: "company-reservations"
  mount Sidekiq::Web => "/sidekiq" # mount Sidekiq::Web in your Rails app
  root "books#index"
end
