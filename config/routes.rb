Spree::Core::Engine.add_routes do
  namespace :admin do
    resources :orders do
      resources :addresses
    end
    resources :users do
      get 'addresses/:address_id/edit', to: 'users#edit_address', as: :edit_address
      put 'addresses/:address_id/edit', to: 'users#edit_address', as: :edit_address_put
      put 'addresses/update_addresses', to: 'users#update_addresses', as: :update_addresses
    end
  end

  resources :addresses do
    member do
      patch :update_default
    end
  end
end
