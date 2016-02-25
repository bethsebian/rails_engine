Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :customers, only: [:index, :show], defaults: { format: 'json' } do
        get '/transactions',  to: 'customers/transactions#index', defaults: { format: 'json' }
        get '/invoices',      to: 'customers/invoices#index', defaults: { format: 'json' }
      end

      resources :invoice_items, only: [:index, :show], defaults: { format: 'json' } do
        get '/item',          to: 'invoice_items/items#show', defaults: { format: 'json' }
        get '/invoice',       to: 'invoice_items/invoices#show', defaults: { format: 'json' }
      end

      resources :invoices, only: [:index, :show], defaults: { format: 'json' } do
        get '/transactions',  to: 'invoices/transactions#index', defaults: { format: 'json' }
        get '/invoice_items', to: 'invoices/invoice_items#index', defaults: { format: 'json' }
        get '/items',         to: 'invoices/items#index', defaults: { format: 'json' }
        get '/customer',      to: 'invoices/customers#show', defaults: { format: 'json' }
        get '/merchant',      to: 'invoices/merchants#show', defaults: { format: 'json' }
      end

      resources :items, only: [:index, :show], defaults: { format: 'json' } do
        get '/invoice_items', to: 'items/invoice_items#index', defaults: { format: 'json' }
        get '/merchant',      to: 'items/merchants#show', defaults: { format: 'json' }
      end

      get '/merchants/most_revenue',  to: 'merchants/analysis#index', defaults: { format: 'json' }

      resources :merchants, only: [:index, :show], defaults: { format: 'json' } do
        get '/items',         to: 'merchants/items#index', defaults: { format: 'json' }
        get '/invoices',      to: 'merchants/invoices#index', defaults: { format: 'json' }
        get '/revenue',       to: 'merchants/revenues#show', defaults: { format: 'json' }
      end

      resources :transactions, only: [:index, :show], defaults: { format: 'json' } do
        get '/invoice',       to: 'transactions/invoices#show', defaults: { format: 'json' }
      end

      # resources :transactions do
      #   resources :comments, only:
      #   get '/find' => '/find#show'
      #   get '/find_all' => '/find#index'
      #
      # end
      #
    end
  end
end
