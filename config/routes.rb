Rails.application.routes.draw do
  get 'home/index'

  root to: 'home#index'
  resource :github_webhooks, only: :create, defaults: { formats: :json }
end
