Rails.application.routes.draw do
  resources :books, only: %i[index show new create]
  root "books#index"
end
