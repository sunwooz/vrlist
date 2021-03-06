Rails.application.routes.draw do

  post '/rate' => 'rater#create', :as => 'rate'
  devise_for :users
  root to: 'games#index'

  #posts
  get '/posts/tags/:tag' => 'posts#index', as: :posts_tag
  get '/posts/new' => 'posts#new', as: :new_post
  post '/posts' => 'posts#create'
  get '/post/:id' => 'posts#show', as: :post
  delete '/post/:id' => 'posts#destroy'
  get '/post/:id/edit' => 'posts#edit', as: :edit_post
  patch '/post/:id' => 'posts#update'

  #games
  #get '/gearvr/games_list' => 'games#link_index'
  get '/gearvr' => 'games#index', as: :games
  get '/gearvr/new' => 'games#new', as: :new_game
  post '/gearvr' => 'games#create'
  get '/gearvr/:id' => 'games#show', as: :game
  get '/gearvr/:id/edit' => 'games#edit', as: :edit_game
  patch '/gearvr/:id' => 'games#update'
  delete '/gearvr/:id' => 'games#destroy'
  get '/add_genre/:genre' => 'games#add_genre', as: :add_genre

  #developers
  get 'gearvr/developer/:developer' => 'developers#show', as: :developer

  #pages
  get '/about-vrmachine' => 'pages#about'
  
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
