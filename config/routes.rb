Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'libraries#index'

  resources :terms
  resources :node_mappings

  resources :spreadsheets do
    member do
      post :import
    end
  end

  resources :libraries do
    collection do
      get :spreadsheet
    end

    # we want to be able to view and do in-place-edits across the library's
    # locations, but create and modify individual hours at the location level (below)
    resources :term_hours, only: :index

    resources :locations do
      member do
        get :hours
      end

      resources :term_hours, except: :index
      resources :calendars
    end
  end

  resource :feedback_form, path: "feedback", only: [:new, :create]
  get "feedback" => "feedback_forms#new"

  # shim route for bootstrap-editable-form
  # see https://github.com/bootstrap-ruby/bootstrap-editable-rails/blob/7217779426f9253dcbc59b8b229537cf369b0f90/app/assets/javascripts/bootstrap-editable-rails.js.coffee#L29
  put 'libraries/:library_id/locations/:location_id/calendars' => 'calendars#create'
  put 'libraries/:library_id/locations/:location_id/term_hours' => 'term_hours#create'

  get 'drupal/hours_:month' => 'libraries#hours_drupal', as: :drupal_hours
  get 'api/v1/library/:library_id/location/:id/hours/for/:when' => 'locations#hours_v1'

  # Authorization routes
  get 'webauth/login' => 'authorization#login', as: :login
  get 'webauth/logout' => 'authorization#logout', as: :logout
end
