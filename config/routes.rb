# The priority is based upon order of creation: first created -> highest priority.
# See how all your routes lay out with "rake routes".
Rails.application.routes.draw do
  # Orders
  resources :orders
  match '/recieving', to: 'orders#recieving', via: 'get', as: 'recieving'
  match '/remove_item', to: 'orders#remove_item', via: 'post', as: 'remove_item'
  match '/update_values', to: 'orders#update_values', via: 'post', as: 'update_values'

  # Inventores
  resources :inventories

  # Parts resources
  resources :parts
  match '/catalog', to: 'parts#catalog', via: 'get', as: 'catalog'

  # APIs for the cart interface
  match '/add_part', to: 'carts#add_part', via: 'post', as: 'add_part'
  match '/remove_part', to: 'carts#remove_part', via: 'post', as: 'remove_part'
  match '/update_part', to: 'carts#update_part', via: 'post', as: 'update_part'
  match '/update_part_keep', to: 'carts#update_part_keep', via: 'post', as: 'update_part_keep'
  match '/item_count', to: 'carts#item_count', via: 'post', as: 'item_count'

  # User resources and 
  devise_for :users
  resources :users
  match '/users/add_user',    to: 'users#add_user',    via: 'post', as: 'add_user'
  match '/users/remove_user', to: 'users#remove_user', via: 'post', as: 'remove_user'
  match '/users/update_role', to: 'users#update_role', via: 'post', as: 'update_role'

  # Routes the to the homepage and static pages
  root 'static_pages#home'
  match '/help',    to: 'static_pages#help',    via: 'get'
  match '/about',   to: 'static_pages#about',   via: 'get'

  # Routing for the admin  pages
  match '/admin', to: 'admin#index', via: 'get', as: 'admin'

  #Routing for POS
  match '/pos', to: 'pos#index', via: 'get', as: 'pos'
  match '/pos/returns', to: 'pos#returns', via: 'get', as: 'returns'
  match '/pos/recipt/:id', to: 'pos#recipt', via: 'get', as: 'recipt'

  #Routing for transactions
  resources :transactions, :only => [:show, :index, :destroy]
  match '/transactions/get_totals', to: 'transactions#get_totals', via: 'post', as: 'get_totals'
  match '/transactions/get_cart', to: 'transactions#get_cart', via: 'post', as: 'get_cart'
  match '/checkout', to: 'transactions#checkout', via: 'post', as: 'checkout'
  match '/return', to: 'transactions#return', via: 'post', as: 'return'

  # Reporting APIs
  match '/reports/daily', to: 'reports#daily', via: 'get', as: 'daily_report'
  match '/reports/weekly', to: 'reports#weekly', via: 'get', as: 'weekly_report'
  match '/reports/monthly', to: 'reports#monthly', via: 'get', as: 'monthly_report'
  match '/reports/quarterly', to: 'reports#quarterly', via: 'get', as: 'quarterly_report'
  match '/reports/yearly', to: 'reports#yearly', via: 'get', as: 'yearly_report'
  match '/reports/audit', to: 'reports#audit', via: 'get', as: 'audit_report'
  match '/reports/po', to: 'reports#po_report', via: 'get', as: 'po_report'
  match '/reports/inventory', to: 'reports#inventory', via: 'get', as: 'inventory_report'

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
