require_dependency "bill_of_materialx/application_controller"

module BillOfMaterialx
  class BomsController < ApplicationController
    before_filter :require_employee
    before_filter :load_parent_record
        
    def index
      @title = t('BOMs')
      @boms = params[:bill_of_materialx_boms][:model_ar_r]  #returned by check_access_right
      @boms = @boms.where(:project_id => BillOfMaterialx.project_class.where(:customer_id => @customer.id).select('id')) if @customer
      @boms = @boms.where(:project_id => @project.id) if @project       
      @boms = @boms.page(params[:page]).per_page(@max_pagination) 
      @erb_code = find_config_const('bom_index_view', 'bill_of_materialx')
    end
  
    def new
      @title = t('New BOM')
      @bom = BillOfMaterialx::Bom.new()
      @qty_unit = find_config_const('piece_unit').split(',').map(&:strip)
      @erb_code = find_config_const('bom_new_view', 'bill_of_materialx')
    end
  
    def create
      @bom = BillOfMaterialx::Bom.new(params[:bom], :as => :role_new)
      @bom.last_updated_by_id = session[:user_id]
      if @bom.save
        redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Saved!")
      else
        @project = BillOfMaterialx.project_class.find_by_id(params[:bom][:project_id]) if params[:bom].present? && params[:bom][:project_id].present?
        @customer = BillOfMaterialx.customer_class.find_by_id(@project.customer_id) if params[:bom].present? && params[:bom][:project_id].present?
        @qty_unit = find_config_const('piece_unit').split(',').map(&:strip)
        flash[:notice] = t('Data Error. Not Saved!')
        render 'new'
      end
    end
  
    def edit
      @title = t('Update BOM')
      @bom = BillOfMaterialx::Bom.find_by_id(params[:id])
      @qty_unit = find_config_const('piece_unit').split(',').map(&:strip)
      @erb_code = find_config_const('bom_edit_view', 'bill_of_materialx')
      #if @bom.wf_state.present? && @bom.current_state != :initial_state
       # redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=NO Update. Record Being Processed!")
      #end
    end
  
    def update
      @bom = BillOfMaterialx::Bom.find_by_id(params[:id])
      @bom.last_updated_by_id = session[:user_id]
      if @bom.update_attributes(params[:bom], :as => :role_update)
        redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Updated!")
      else
        @qty_unit = find_config_const('piece_unit').split(',').map(&:strip)
        flash[:notice] = t('Data Error. Not Updated!')
        render 'edit'
      end
    end
  
    def show
      @title = t('BOM Info')
      @bom = BillOfMaterialx::Bom.find_by_id(params[:id])
      @erb_code = find_config_const('bom_show_view', 'bill_of_materialx')
    end
    
    protected
    def load_parent_record
      @customer = BillOfMaterialx.customer_class.find_by_id(params[:customer_id]) if params[:customer_id].present?
      @project = BillOfMaterialx.project_class.find_by_id(params[:project_id]) if params[:project_id].present?
      @customer = BillOfMaterialx.customer_class.find_by_id(@project.customer_id) if params[:project_id].present?
      @project = BillOfMaterialx.project_class.find_by_id(BillOfMaterialx::Bom.find_by_id(params[:id]).project_id) if params[:id].present?
      @customer = BillOfMaterialx.customer_class.find_by_id(@project.customer_id) if params[:id].present?
    end
    
  end
end
