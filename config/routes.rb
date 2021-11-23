Rails.application.routes.draw do
  resources :products
  devise_for :users, controllers: { sessions: "users/sessions" }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index', as: 'home'
  get '/shop', to:'home#shop',as:'shop'
  post '/shop', to:'home#shop',as:'shop_post'

  get '/cart', to:'cart#index',as:'cart'
  post '/cart/:id', to:'cart#index',as:'cart_post'


  #search url
  # get '/search', to:'home#search', as:'search'
  # post '/search', to:'home#search', as:'search_post'

  #admin routes
  get '/admin/sessions/login',to:'admin/sessions#login', as:'admin_login'
  post '/admin/sessions/login',to:'admin/sessions#login',as:'admin_login_post'
  get '/admin/sessions/signup',to:'admin/sessions#signup',as:'admin_signup'
  post '/admin/sessions/signup',to:'admin/sessions#signup',as:'admin_signup_post'
  delete '/admin/sessions/logout',to:'admin/sessions#logout',as:'admin_logout'
  get '/admin/sessions/logout',to:'admin/sessions#logout',as:'admin_get_logout'

  get '/trash', to:'home#trash'
  get '/test', to:'home#test'

  #adding to cart
  get '/cart/add/:id', to: 'cart#add', as: 'add_cart'
  post '/cart/add/:id', to: 'cart#add', as: 'add_cart_post'
  get '/cart/update/:id', to: 'cart#update', as: 'update_cart'
  post '/cart/update/:id', to: 'cart#update', as: 'update_cart_post'
  delete '/cart/order/delete/:id', to: 'cart#delete', as: 'cart_order_delete'

  #payment /currently using active merchant
  get '/checkout', to:'checkout#index', as: 'checkout'
  post '/checkout', to:'checkout#index', as: 'checkout_post'
  get '/checkout/payment', to:'checkout#payment', as: 'checkout_payment'
  post '/checkout/payment', to:'checkout#payment', as: 'checkout_payment_post'
  get '/checkout/payment/successfull', to: "checkout#successfull", as:'successfull_payment'
end
