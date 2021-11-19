Rails.application.routes.draw do
  resources :products
  devise_for :users, controllers: { sessions: "users/sessions" }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index', as: 'home'
  get '/shop', to:'home#shop',as:'shop'
  get '/cart', to:'home#cart',as:'cart'
  get '/checkout', to:'home#checkout',as:'checkout'
  get '/contact', to:'home#contact',as:'contact'

  #admin routes
  get '/admin/sessions/login',to:'admin/sessions#login', as:'admin_login'
  post '/admin/sessions/login',to:'admin/sessions#login',as:'admin_login_post'
  get '/admin/sessions/signup',to:'admin/sessions#signup',as:'admin_signup'
  post '/admin/sessions/signup',to:'admin/sessions#signup',as:'admin_signup_post'
  delete '/admin/sessions/logout',to:'admin/sessions#logout',as:'admin_logout'
end
