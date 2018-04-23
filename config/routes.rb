Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  post '/register' => 'secure_registers#push_out'
  get '/accept-registrant/:key' => 'secure_registers#accept_new_registrant', as: :accept_registrant
end
