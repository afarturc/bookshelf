Rails.application.routes.draw do
  resources :books, only: %i[index new create]
  root "books#index"
end
