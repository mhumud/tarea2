Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :entries, path: "news", except: :update do
    resources :comments, except: :update
    put "comments/:id", to: "comments#put"
    patch "comments/:id", to: "comments#patch"
  end
  put "news/:id", to: "entries#put"
  patch "news/:id", to: "entries#patch"
end
