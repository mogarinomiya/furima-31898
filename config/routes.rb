Rails.application.routes.draw do
  get 'items', to: 'items#index'
  root to: 'items#index'

end
