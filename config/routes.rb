Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
#  get 'users/registrations/new_editor', to: 'devise/registrations#new_editor'
  devise_scope :user do
#    get "users/registrations/new_editor", to: "devise/registrations#new_editor"
    get "users/registrations/new_editor", to: "users/registrations#new_editor"
  end


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  resources :companies do
    get :autocomplete_company_name, :on => :collection
    get :autocomplete_archetype_name, :on => :collection
    get :autocomplete_guideline_name, :on => :collection
    get :autocomplete_practice_implementation, :on => :collection
    resources :practices
  end

  get '/autocomplete/implementations', to: 'practices#autocomplete_implementations'

  resources :guidelines
  resources :archetypes do
    resources :practices
  end

  get 'documents/terms_of_service'
  get 'documents/glossary'
  get 'documents/credit'

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
