# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

# Defines the root path route ("/")

Rails.application.routes.draw do

  resources :tickets
  
  devise_for :users
  
  root "home#index"

  devise_scope :user do
    get 'users/sign_out' => "devise/sessions#destroy"
  end
  
end
