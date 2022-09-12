Rails.application.routes.draw do
  get "contact", to: "pages#contact"
  get "home", to: "pages#home"
  get 'about', to: "pages#about"
  resources :projects
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  
end
