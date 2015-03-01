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
  
  
  root :to => "authentify/sessions#new"
  get '/signin',  :to => 'authentify/sessions#new'
  get '/signout', :to => 'authentify/sessions#destroy'
  get '/user_menus', :to => 'user_menus#index'
  get '/view_handler', :to => 'authentify/application#view_handler'
end
