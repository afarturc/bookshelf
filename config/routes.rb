Rails.application.routes.draw do
  devise_for :users
  resources :books, only: %i[index show new create edit update]
  root "books#index"
end
