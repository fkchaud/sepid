Rails.application.routes.draw do
  get 'sessions/new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get '/reports', to: 'reports#generate_reports'
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
    post '/start_tender', to: 'orders#start_tender'
    post '/cancel_order', to: 'orders#cancel_order'
    post '/refuse_order', to: 'orders#refuse_order'
    resources :order_details do
      post '/adjust_preventive', to: 'order_details#adjust_preventive'
      post '/refused_preventive', to: 'order_details#refused_preventive'
      get '/show', to: 'order_details#show'
    end
  end
  resources :projects do
    get '/check_expenses', to: 'orders#check_expenses'
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
