Rails.application.routes.draw do
  root "articles#index"
  get "/articles", to: "articles#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
