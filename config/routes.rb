Rails.application.routes.draw do
  root 'diaries#index'
  resources :diaries
  devise_for :users
end