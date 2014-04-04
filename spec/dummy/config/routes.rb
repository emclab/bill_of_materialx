Rails.application.routes.draw do

  mount BillOfMaterialx::Engine => "/bill_of_materialx"
  mount Commonx::Engine => "/commonx"
  mount Authentify::Engine => '/authentify'
  mount Manufacturerx::Engine => '/manufacturer'
  mount Supplierx::Engine => '/supplier'
  mount Kustomerx::Engine => '/customer'
  mount ExtConstructionProjectx::Engine => '/project'
  mount Searchx::Engine => '/search'
  mount InQuotex::Engine => '/in_quote'
  mount StateMachineLogx::Engine => '/sm_log'
  mount BizWorkflowx::Engine => '/biz_wf'
  mount EventTaskx::Engine => '/task'
  
  resource :session
  
  root :to => "authentify::sessions#new"
  match '/signin',  :to => 'authentify::sessions#new'
  match '/signout', :to => 'authentify::sessions#destroy'
  match '/user_menus', :to => 'user_menus#index'
  match '/view_handler', :to => 'authentify::application#view_handler'
end
