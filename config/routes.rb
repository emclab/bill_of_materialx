BillOfMaterialx::Engine.routes.draw do
  
  resources :boms do
    collection do
      get :search
      put :search_results
      #get :stats
      #put :stats_results 
    end
  end
  root :to => 'boms#index'
end
