Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: '/auth'

  resources :restaurants, except: [:new, :edit] do
    resources :reviews, except: [:new, :edit]
  end
end
