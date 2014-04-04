require 'spec_helper'

module BillOfMaterialx
  describe Bom do
    it "should be OK" do
      c = FactoryGirl.build(:bill_of_materialx_bom)
      c.should be_valid
    end
    
    it "should reject nil name" do
      c = FactoryGirl.build(:bill_of_materialx_bom, :name => nil)
      c.should_not be_valid
    end
    
    it "should reject nil unit" do
      c = FactoryGirl.build(:bill_of_materialx_bom, :unit => nil)
      c.should_not be_valid
    end
    
    it "should reject dup name for same project and manufacturer" do
      c = FactoryGirl.create(:bill_of_materialx_bom, :name => "nil")
      c1 = FactoryGirl.build(:bill_of_materialx_bom, :name => "Nil", :project_id => c.project_id, :manufacturer_id => c.manufacturer_id)
      c1.should_not be_valid
    end
    
    it "should reject 0 qty" do
      c = FactoryGirl.build(:bill_of_materialx_bom, :qty => 0)
      c.should_not be_valid
    end
    
    it "should reject 0 project_id" do
      c = FactoryGirl.build(:bill_of_materialx_bom, :project_id => 0)
      c.should_not be_valid
    end

    it "should take nil manufacturer_id" do
      c = FactoryGirl.build(:bill_of_materialx_bom, :manufacturer_id => nil)
      c.should be_valid
    end

  end
end
