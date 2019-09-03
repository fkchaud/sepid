Rails.application.routes.draw do
  get 'sessions/new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :funds_resolutions do
    resources :funds_destinations
  end
  resources :projects
  resources :users
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
  resources :order_types do
    resources :order_type_attributes
    resources :order_detail_attributes
  end
  resources :user_profiles
  resources :orders do
    resources :order_details
  end
  resources :projects do
    resources :orders do
      resources :order_details
    end
    resources :subsection_shifts
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
