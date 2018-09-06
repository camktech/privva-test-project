Rails.application.routes.draw do
  root 'issues#index'
  resources :issues
  resources :users
end
