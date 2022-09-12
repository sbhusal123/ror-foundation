Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "contact", to: "pages#contact"
  get "home", to: "pages#home"
  get 'about', to: "pages#about"
  get "error", to: "pages#error"
  get "blog", to: "pages#blog"

  get 'google', to: redirect("https://google.com")

  resources :projects

  root 'pages#home'

  # error routes, searches from the top
  get "*path", to: redirect("/error")

end
