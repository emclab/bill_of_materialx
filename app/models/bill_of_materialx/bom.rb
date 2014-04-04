module BillOfMaterialx
  class Bom < ActiveRecord::Base
    attr_accessor :project_id_noupdate, :supplier_name, :manufacturer_name, :status_name, :id_noupdate, :wf_comment, :customer_name, :project_name
    attr_accessible :actual_receiving_date, :brief_note, :last_updated_by_id, :manufacturer_id, :name, :order_date, :part_num, :project_id, :qty, :received,
                    :receiving_date, :spec, :status_id, :supplier_id, :unit, :void, :wf_state, :wfid, :customer_name, :project_name,
                    :as => :role_new
    attr_accessible :actual_receiving_date, :brief_note, :last_updated_by_id, :manufacturer_id, :name, :order_date, :part_num, :qty, :received,
                    :receiving_date, :spec, :status_id, :supplier_id, :unit, :void, :wf_state, :wfid,
                    :project_id_noupdate, :supplier_name, :manufacturer_name, :status_name, :customer_name, :project_name,
                    :as => :role_update
    
    belongs_to :project, :class_name => BillOfMaterialx.project_class.to_s
    belongs_to :supplier, :class_name => BillOfMaterialx.supplier_class.to_s
    belongs_to :status, :class_name => 'Commonx::MiscDefinition'
    belongs_to :last_updated_by, :class_name => 'Authentify::User'
    belongs_to :manufacturer, :class_name => BillOfMaterialx.manufacturer_class
    
    validates_presence_of :name, :spec, :unit 
    validates :project_id, :qty, :presence => true,
                                 :numericality => {:greater_than => 0, :only_integer => true}
    validates :name, :uniqueness => {:scope => [:project_id, :manufacturer_id], :case_sensitive => false, :message => I18n.t('No duplicate name')}
    
    
  end
end
