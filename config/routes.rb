Rails.application.routes.draw do
  resources :books, only: %i[index show new create edit update]
  root "books#index"
end
