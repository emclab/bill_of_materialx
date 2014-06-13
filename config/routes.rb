BillOfMaterialx::Engine.routes.draw do
  
  resources :boms do
    collection do
      get :search
      get :search_results
      #get :stats
      #get :stats_results 
    end
  end
  root :to => 'boms#index'
end
