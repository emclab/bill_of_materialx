require 'rails_helper'

RSpec.describe "LinkTests", type: :request do
  describe "GET /bill_of_materialx_link_tests" do
    mini_btn = 'btn btn-mini '
    ActionView::CompiledTemplates::BUTTONS_CLS =
        {'default' => 'btn',
         'mini-default' => mini_btn + 'btn',
         'action'       => 'btn btn-primary',
         'mini-action'  => mini_btn + 'btn btn-primary',
         'info'         => 'btn btn-info',
         'mini-info'    => mini_btn + 'btn btn-info',
         'success'      => 'btn btn-success',
         'mini-success' => mini_btn + 'btn btn-success',
         'warning'      => 'btn btn-warning',
         'mini-warning' => mini_btn + 'btn btn-warning',
         'danger'       => 'btn btn-danger',
         'mini-danger'  => mini_btn + 'btn btn-danger',
         'inverse'      => 'btn btn-inverse',
         'mini-inverse' => mini_btn + 'btn btn-inverse',
         'link'         => 'btn btn-link',
         'mini-link'    => mini_btn +  'btn btn-link',
         'right-span#'         => '2', 
               'left-span#'         => '6', 
               'offset#'         => '2',
               'form-span#'         => '4'
        }
    before(:each) do
      @pagination_config = FactoryGirl.create(:engine_config, :engine_name => nil, :engine_version => nil, :argument_name => 'pagination', :argument_value => 30)
      piece_unit = FactoryGirl.create(:engine_config, :engine_name => nil, :engine_version => nil, :argument_name => 'piece_unit', :argument_value => "set, piece")
      z = FactoryGirl.create(:zone, :zone_name => 'hq')
      type = FactoryGirl.create(:group_type, :name => 'employee')
      ug = FactoryGirl.create(:sys_user_group, :user_group_name => 'ceo', :group_type_id => type.id, :zone_id => z.id)
      @role = FactoryGirl.create(:role_definition)
      ur = FactoryGirl.create(:user_role, :role_definition_id => @role.id)
      ul = FactoryGirl.build(:user_level, :sys_user_group_id => ug.id)
      @u = FactoryGirl.create(:user, :user_levels => [ul], :user_roles => [ur])
      
      user_access = FactoryGirl.create(:user_access, :action => 'index', :resource =>'bill_of_materialx_boms', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "BillOfMaterialx::Bom.where(:void => false).order('created_at DESC')")
        
      user_access = FactoryGirl.create(:user_access, :action => 'create', :resource =>'bill_of_materialx_boms', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
      user_access = FactoryGirl.create(:user_access, :action => 'create', :resource =>'bill_of_materialx_boms', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
      user_access = FactoryGirl.create(:user_access, :action => 'update', :resource =>'bill_of_materialx_boms', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
      user_access = FactoryGirl.create(:user_access, :action => 'update', :resource =>'bill_of_materialx_boms', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
      user_access = FactoryGirl.create(:user_access, :action => 'show', :resource =>'bill_of_materialx_boms', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "record.last_updated_by_id == session[:user_id]")
      user_access = FactoryGirl.create(:user_access, :action => 'create_bom', :resource => 'commonx_logs', :role_definition_id => @role.id, :rank => 1,
      :sql_code => "")
      ua1 = FactoryGirl.create(:user_access, :action => 'index', :resource => 'event_taskx_event_tasks', :role_definition_id => @role.id, :rank => 1,
           :sql_code => "EventTaskx::EventTask.where(:cancelled => false).order('created_at DESC')")
      user_access = FactoryGirl.create(:user_access, :action => 'index', :resource =>'in_quotex_quotes', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "InQuotex::Quote.where(:void => false).order('created_at DESC')")
        
      #@pur_sta = FactoryGirl.create(:commonx_misc_definition, 'for_which' => 'bom_status')
      @cust = FactoryGirl.create(:kustomerx_customer) 
      @proj = FactoryGirl.create(:ext_construction_projectx_project, :customer_id => @cust.id) 
      @mfg = FactoryGirl.create(:manufacturerx_manufacturer)
      quote_task = FactoryGirl.create(:event_taskx_event_task, :task_category => 'quote_bom')
      in_quote = FactoryGirl.create(:in_quotex_quote, :task_id => quote_task.id)
      
      visit '/'
      #save_and_open_page
      fill_in "login", :with => @u.login
      fill_in "password", :with => @u.password
      click_button 'Login'
    end
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      supplier = FactoryGirl.create(:supplierx_supplier)
      status = FactoryGirl.create(:commonx_misc_definition, :for_which => 'bom_status')
      task = FactoryGirl.create(:bill_of_materialx_bom, :project_id => @proj.id, :supplier_id => supplier.id, :status_id => status.id, 
                                  :manufacturer_id => @mfg.id, :last_updated_by_id => @u.id, unit: 'set')
      visit bill_of_materialx.boms_path
      save_and_open_page
      expect(page).to have_content('BOMs')
      click_link 'Edit'
      expect(page).to have_content('Update BOM')
      fill_in 'bom_name', :with => 'a test bom'
      click_button 'Save'
      #
      visit bill_of_materialx.boms_path
      save_and_open_page
      expect(page).to have_content('a test bom')
      #with wrong data
      visit bill_of_materialx.boms_path
      #save_and_open_page
      expect(page).to have_content('BOMs')
      click_link 'Edit'
      fill_in 'bom_name', :with => ''
      fill_in 'bom_spec', :with => 'a test spec-bad-edit'
      
      click_button 'Save'
      save_and_open_page
      #
      visit bill_of_materialx.boms_path
      expect(page).not_to have_content('a test spec-bad-edit')
      
      #index page should see link for quote task and quotes
      visit bill_of_materialx.boms_path
      #save_and_open_page
      expect(page).to have_content('BOMs')
      save_and_open_page
      click_link 'Quote Tasks'
      save_and_open_page
      #
      visit bill_of_materialx.boms_path
      #save_and_open_page
      expect(page).to have_content('BOMs')
      save_and_open_page
      click_link 'Quotes'
      save_and_open_page
      
      visit bill_of_materialx.boms_path
      click_link task.id.to_s
      #save_and_open_page
      expect(page).to have_content('BOM Info')
      click_link 'New Log'
      #save_and_open_page
      expect(page).to have_content('Log')
      
      visit bill_of_materialx.new_bom_path(:project_id => @proj.id)
      save_and_open_page
      expect(page).to have_content('New BOM')
      fill_in 'bom_name', :with => 'a test bom'
      fill_in 'bom_spec', :with => 'a test spec-good'
      fill_in 'bom_qty', :with => 100
      select('piece', :from => 'bom_unit')
      click_button 'Save'
      #
      visit bill_of_materialx.boms_path
      expect(page).to have_content('a test spec-good')
      #with wrong data
      visit bill_of_materialx.new_bom_path(:project_id => @proj.id)
      expect(page).to have_content('New BOM')
      fill_in 'bom_name', :with => ''
      fill_in 'bom_spec', :with => 'a test spec-bad'
      fill_in 'bom_qty', :with => 100
      select('piece', :from => 'bom_unit')
      click_button 'Save'
      save_and_open_page
      #
      visit bill_of_materialx.boms_path
      expect(page).not_to have_content('a test spec-bad')
      
    end
  end
end
