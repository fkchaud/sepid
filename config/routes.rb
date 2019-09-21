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
    post '/orders/continue(.:format)', to: 'orders#continue'
    resources :orders
    resources :subsection_shifts, only: [:index, :show, :new, :create]
    get '/subsection_shifts/:id/approve',
        to: 'subsection_shifts#approve',
        as: 'approve_subsection_shift'
    get '/subsection_shifts/:id/reject',
        to: 'subsection_shifts#reject',
        as: 'reject_subsection_shift'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
