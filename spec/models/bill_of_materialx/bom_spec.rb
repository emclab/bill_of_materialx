require 'rails_helper'

module BillOfMaterialx
  RSpec.describe Bom , type: :model do
    it "should be OK" do
      c = FactoryGirl.build(:bill_of_materialx_bom)
      expect(c).to be_valid
    end
    
    it "should reject nil name" do
      c = FactoryGirl.build(:bill_of_materialx_bom, :name => nil)
      expect(c).not_to be_valid
    end
    
    it "should reject nil unit" do
      c = FactoryGirl.build(:bill_of_materialx_bom, :unit => nil)
      expect(c).not_to be_valid
    end
    
    it "should reject nil spec" do
      c = FactoryGirl.build(:bill_of_materialx_bom, :spec => nil)
      expect(c).not_to be_valid
    end
    
    it "should reject dup name for same project and manufacturer" do
      c = FactoryGirl.create(:bill_of_materialx_bom, :name => "nil")
      c1 = FactoryGirl.build(:bill_of_materialx_bom, :name => "Nil", :project_id => c.project_id, :manufacturer_id => c.manufacturer_id)
      expect(c1).not_to be_valid
    end
    
    it "should reject 0 qty" do
      c = FactoryGirl.build(:bill_of_materialx_bom, :qty => 0)
      expect(c).not_to be_valid
    end
    
    it "should reject 0 project_id" do
      c = FactoryGirl.build(:bill_of_materialx_bom, :project_id => 0)
      expect(c).not_to be_valid
    end

    it "should take nil manufacturer_id" do
      c = FactoryGirl.build(:bill_of_materialx_bom, :manufacturer_id => nil)
      expect(c).to be_valid
    end

  end
end
