Rails.application.routes.draw do
  root 'diaries#index'
  resources :diaries
  resources :drafts
  resources :pictures
  resources :pockets
  resources :users
  devise_for :users
  get "/ajax", to: "users#ajax"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
