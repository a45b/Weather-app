Rails.application.routes.draw do  
  match '/', to: 'home#index', via: [:get, :post]

  root 'home#index'
end
