Rails.application.routes.draw do
  
  devise_for :users, path: "", path_names: { sign_in: "login", sign_out: "logout", sign_up: "register"}
  
  get "about" => "pages#about", as: "about"
  get "contact" => "pages#contact", as: "contact"
  get "home" => "pages#home", as: "home"

  resources :blogs
  get ":id/change_status" => "blogs#toggle_status", as: "toggle_status"

  resources :portfolios, except: [:show] do
    put :sort, on: :collection
  end
  #Now i can create my own show-action with singular portfolio in URL
  get "angular-items" => "portfolios#angular", as: "angular_items"
  get "portfolio/:id" => "portfolios#show", as: "show_portfolio"


  root "pages#home"

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root "welcome#index"

  # Example of regular route:
  #   get "products/:id" => "catalog#view"

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get "products/:id/purchase" => "catalog#purchase", as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get "short"
  #       post "toggle"
  #     end
  #
  #     collection do
  #       get "sold"
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
  #       get "recent", on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post "toggle"
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
