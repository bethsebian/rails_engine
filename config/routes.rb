Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :invoices, only: [:index, :show], defaults: { format: 'json' }
      resources :invoice_items, only: [:index, :show], defaults: { format: 'json' }
    end
  end
end
