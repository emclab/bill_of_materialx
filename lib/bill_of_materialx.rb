require "bill_of_materialx/engine"

module BillOfMaterialx
  mattr_accessor :project_class, :supplier_class, :manufacturer_class, :customer_class, :task_class
                 
  
  def self.project_class
    @@project_class.constantize
  end
  
  def self.customer_class
    @@customer_class.constantize
  end
  
  def self.task_class
    @@task_class.constantize
  end
  
  def self.supplier_class
    @@supplier_class.constantize
  end
  
  def self.manufacturer_class
    @@manufacturer_class.constantize
  end
end
