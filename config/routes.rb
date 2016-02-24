Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :customers, only: [:index, :show], defaults: { format: 'json' }
      resources :invoice_items, only: [:index, :show], defaults: { format: 'json' }
      resources :invoices, only: [:index, :show], defaults: { format: 'json' }
      resources :items, only: [:index, :show], defaults: { format: 'json' }

      resources :merchants, only: [:index, :show], defaults: { format: 'json' } do
        get '/items', to: 'merchants/items#index', defaults: { format: 'json' }
        get '/invoices', to: 'merchants/invoices#index', defaults: { format: 'json' }
      end

      resources :transactions, only: [:index, :show], defaults: { format: 'json' }

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
