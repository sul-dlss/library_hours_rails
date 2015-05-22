Rails.application.routes.draw do
  root to: 'libraries#index'
  resources :node_mappings
  resources :spreadsheets do
    member do
      post :import
    end
  end
  resources :libraries do
    resources :locations do
      member do
        get :hours
      end

      resources :calendars
    end
  end

  # shim route for bootstrap-editable-form
  # see https://github.com/bootstrap-ruby/bootstrap-editable-rails/blob/7217779426f9253dcbc59b8b229537cf369b0f90/app/assets/javascripts/bootstrap-editable-rails.js.coffee#L29
  put 'libraries/:library_id/locations/:location_id/calendars' => 'calendars#create'

  get 'drupal/hours_:month' => 'libraries#hours_drupal'
  get 'api/v1/library/:library_id/location/:id/hours/for/:when' => 'locations#hours_v1'

  # Authorization routes
  get 'webauth/login' => 'authorization#login', as: :login
  get 'webauth/logout' => 'authorization#logout', as: :logout
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
