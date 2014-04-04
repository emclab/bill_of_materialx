# This migration comes from manufacturerx (originally 20140328121100)
class CreateManufacturerxManufacturers < ActiveRecord::Migration
  def change
    create_table :manufacturerx_manufacturers do |t|
      t.string :name
      t.string :short_name
      t.text :contact_info
      t.string :phone
      t.string :cell
      t.string :fax
      t.text :main_product
      t.boolean :active, :default => true
      t.integer :last_updated_by_id
      t.text :address
      t.integer :quality_system_id

      t.timestamps
    end
    
    add_index :manufacturerx_manufacturers, :name
  end
end
