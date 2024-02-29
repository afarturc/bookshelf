Rails.application.routes.draw do
  resources :books, only: %i[index, show]
  root "books#index"
end
