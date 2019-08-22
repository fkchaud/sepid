Rails.application.routes.draw do
  resources :subsection_shift_statuses
  resources :subsections
  get 'welcome/index'
  root 'welcome#index'

  resources :project_types
  resources :project_statuses
  resources :university_positions
  resources :order_types do
    resources :order_type_attributes
    resources :order_detail_attributes
  end
  resources :user_profiles
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
