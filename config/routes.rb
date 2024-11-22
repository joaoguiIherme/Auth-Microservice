Rails.application.routes.draw do
  namespace :auth do
    post 'register', to: 'auth#register'
    post 'login', to: 'auth#login'
    get 'validate', to: 'auth#validate'
  end
end
