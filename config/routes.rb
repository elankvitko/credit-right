Rails.application.routes.draw do
  devise_for :users
  resources :users

  devise_scope :user do
    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end

    authenticated do
      root 'home#index'
    end
  end

  post '/register' => 'secure_registers#push_out'
  get '/accept-registrant/:key' => 'secure_registers#accept_new_registrant', as: :accept_registrant
  get '/complete-registration/:key' => 'secure_registers#complete_signup', as: :complete_registrant
  get '/dashboard' => 'home#index', as: :dashboard
end
