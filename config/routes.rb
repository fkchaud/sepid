Rails.application.routes.draw do
  resources :resolution_types
  resources :order_statuses
  resources :value_statuses
  resources :subsection_shift_statuses
  resources :subsections
  get 'welcome/index'
  root 'welcome#index'

  resources :project_types
  resources :project_statuses
  resources :university_positions
  resources :order_types
  resources :user_profiles
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
