require 'rails_helper'

module BillOfMaterialx
  RSpec.describe BomsController, type: :controller do
    routes {BillOfMaterialx::Engine.routes}
    before(:each) do
      expect(controller).to receive(:require_signin)
      expect(controller).to receive(:require_employee)
           
    end
    before(:each) do
      @pagination_config = FactoryGirl.create(:engine_config, :engine_name => nil, :engine_version => nil, :argument_name => 'pagination', :argument_value => 30)
      engine_config = FactoryGirl.create(:engine_config, :engine_name => nil, :engine_version => nil, :argument_name => 'piece_unit', :argument_value => "set, piece")
      z = FactoryGirl.create(:zone, :zone_name => 'hq')
      type = FactoryGirl.create(:group_type, :name => 'employee')
      ug = FactoryGirl.create(:sys_user_group, :user_group_name => 'ceo', :group_type_id => type.id, :zone_id => z.id)
      @role = FactoryGirl.create(:role_definition)
      ur = FactoryGirl.create(:user_role, :role_definition_id => @role.id)
      ul = FactoryGirl.build(:user_level, :sys_user_group_id => ug.id)
      @u = FactoryGirl.create(:user, :user_levels => [ul], :user_roles => [ur])
      
      @pur_sta = FactoryGirl.create(:commonx_misc_definition, 'for_which' => 'purchasing_part')
      @cust = FactoryGirl.create(:kustomerx_customer) 
      @proj = FactoryGirl.create(:ext_construction_projectx_project, :customer_id => @cust.id) 
      @mfg = FactoryGirl.create(:manufacturerx_manufacturer)
      
      session[:user_role_ids] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id).user_role_ids
        
    end
    
    render_views
    
    describe "GET 'index'" do
      it "returns parts" do
        user_access = FactoryGirl.create(:user_access, :action => 'index', :resource =>'bill_of_materialx_boms', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "BillOfMaterialx::Bom.where(:void => false).order('created_at DESC')")
        session[:user_id] = @u.id
        task = FactoryGirl.create(:bill_of_materialx_bom, :project_id => @proj.id)
        task1 = FactoryGirl.create(:bill_of_materialx_bom, :project_id => @proj.id, :name => 'a new task')
        get 'index'
        expect(assigns[:boms]).to match_array([task, task1])
      end
      
      it "should only return the part for a project_id" do
        user_access = FactoryGirl.create(:user_access, :action => 'index', :resource =>'bill_of_materialx_boms', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "BillOfMaterialx::Bom.where(:void => false).order('created_at DESC')")
        session[:user_id] = @u.id
        task = FactoryGirl.create(:bill_of_materialx_bom, :project_id => @proj.id)
        task1 = FactoryGirl.create(:bill_of_materialx_bom, :project_id => @proj.id + 1, :name => 'a new task')
        get 'index', {:project_id => @proj.id}
        expect(assigns[:boms]).to match_array([task])
      end
      
      it "should only return the part for the customer_id" do
        user_access = FactoryGirl.create(:user_access, :action => 'index', :resource =>'bill_of_materialx_boms', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "BillOfMaterialx::Bom.where(:void => false).order('created_at DESC')")
        session[:user_id] = @u.id
        task = FactoryGirl.create(:bill_of_materialx_bom, :project_id => @proj.id, :void => true)
        task1 = FactoryGirl.create(:bill_of_materialx_bom, :project_id => @proj.id, :name => 'a new task')
        get 'index', {:project_id => @proj.id, :customer_id => @cust.id}
        expect(assigns[:boms]).to match_array([task1])
      end
            
    end
  
    describe "GET 'new'" do
      it "returns bring up new page" do
        user_access = FactoryGirl.create(:user_access, :action => 'create', :resource =>'bill_of_materialx_boms', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        get 'new', { :project_id => @proj.id}
        expect(response).to be_success
      end
      
    end
  
    describe "GET 'create'" do
      it "should create and redirect after successful creation" do
        user_access = FactoryGirl.create(:user_access, :action => 'create', :resource =>'bill_of_materialx_boms', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        task = FactoryGirl.attributes_for(:bill_of_materialx_bom, :project_id => @proj.id )  
        get 'create', {:bom => task, :project_id => @proj.id}
        expect(response).to redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Saved!")
      end
      
      it "should render 'new' if data error" do        
        user_access = FactoryGirl.create(:user_access, :action => 'create', :resource =>'bill_of_materialx_boms', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        task = FactoryGirl.attributes_for(:bill_of_materialx_bom, :project_id => @proj.id, :name => nil)
        get 'create', {:bom => task, :project_id => @proj.id}
        expect(response).to render_template('new')
      end
    end
  
    describe "GET 'edit'" do
      it "returns edit page" do
        user_access = FactoryGirl.create(:user_access, :action => 'update', :resource =>'bill_of_materialx_boms', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        task = FactoryGirl.create(:bill_of_materialx_bom, :project_id => @proj.id)
        get 'edit', {:id => task.id}
        expect(response).to be_success
      end
      
    end
  
    describe "GET 'update'" do
      it "should return success and redirect" do
        user_access = FactoryGirl.create(:user_access, :action => 'update', :resource =>'bill_of_materialx_boms', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        task = FactoryGirl.create(:bill_of_materialx_bom, :project_id => @proj.id)
        get 'update', {:id => task.id, :bom => {:name => 'new name'}}
        expect(response).to redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Updated!")
      end
      
      it "should render edit with data error" do
        user_access = FactoryGirl.create(:user_access, :action => 'update', :resource =>'bill_of_materialx_boms', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        task = FactoryGirl.create(:bill_of_materialx_bom, :project_id => @proj.id)
        get 'update', {:id => task.id, :bom => {:name => ''}}
        expect(response).to render_template('edit')
      end
    end
  
    describe "GET 'show'" do
      it "returns http success" do
        user_access = FactoryGirl.create(:user_access, :action => 'show', :resource =>'bill_of_materialx_boms', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "record.last_updated_by_id == session[:user_id]")
        session[:user_id] = @u.id
        supplier = FactoryGirl.create(:supplierx_supplier)
        status = FactoryGirl.create(:commonx_misc_definition, :for_which => 'part_purchasing_status')
        task = FactoryGirl.create(:bill_of_materialx_bom, :project_id => @proj.id, :supplier_id => supplier.id, :status_id => status.id, 
                                  :manufacturer_id => @mfg.id, :last_updated_by_id => @u.id)
        get 'show', {:id => task.id}
        expect(response).to be_success
      end
    end
    
  end
end
