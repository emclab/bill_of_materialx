class CreateBillOfMaterialxBoms < ActiveRecord::Migration
  def change
    create_table :bill_of_materialx_boms do |t|
      t.string :name
      t.string :part_num
      t.text :spec
      t.integer :project_id
      t.integer :qty
      t.string :unit
      t.integer :manufacturer_id
      t.integer :supplier_id
      t.integer :last_updated_by_id
      t.boolean :void, :default => false
      t.boolean :received, :default => false
      t.date :receiving_date
      t.date :actual_receiving_date
      t.date :order_date
      t.integer :status_id
      t.string :wf_state
      t.string :wfid
      t.text :brief_note

      t.timestamps
    end
    
    add_index :bill_of_materialx_boms, :name
    add_index :bill_of_materialx_boms, :project_id
    add_index :bill_of_materialx_boms, :wf_state
    add_index :bill_of_materialx_boms, :void
    add_index :bill_of_materialx_boms, :received
    add_index :bill_of_materialx_boms, :status_id
    add_index :bill_of_materialx_boms, :supplier_id
    add_index :bill_of_materialx_boms, :manufacturer_id
  end
end
