Rails.application.routes.draw do
  get '/password_reset/:tmp_token', to: 'password_reset#index'
  patch '/password_reset/reset', to: 'password_reset#reset'
  get 'sessions/new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get '/reports', to: 'reports#generate_reports'
  get '/change_password', to: 'users#change_password'
  post '/change_password', to: 'users#change_password_continue'
  post '/users/password_reset', to: 'users#password_reset'
  get '/forget_password', to: 'users#forget_password'
  mount ReportsKit::Engine, at: '/reports'
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
    resources :order_type_attributes do
      get '/enable_attribute', to: 'order_type_attributes#enable_attribute'
    end
    resources :order_detail_attributes do
      get '/enable_attribute', to: 'order_detail_attributes#enable_attribute'
    end
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
