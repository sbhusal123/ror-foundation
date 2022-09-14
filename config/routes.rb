Rails.application.routes.draw do
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # all of the route items, just like project except the index

  get "contact", to: "pages#contact"
  get "home", to: "pages#home"
  get 'about', to: "pages#about"
  get "error", to: "pages#error"
  get "blog", to: "pages#blog"

  get 'google', to: redirect("https://google.com")

  # nested: /projects/5/tasks/1
  resources :projects do 
    resources :tasks, except: [:index], controller: 'projects/tasks'
  end

  root 'pages#home'

  # error routes, searches from the top
  get "*path", to: redirect("/error")

end
