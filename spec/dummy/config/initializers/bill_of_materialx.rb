BillOfMaterialx.project_class = 'ExtConstructionProjectx::Project'
BillOfMaterialx.supplier_class = 'Supplierx::Supplier'
BillOfMaterialx.manufacturer_class = 'Manufacturerx::Manufacturer'
BillOfMaterialx.customer_class = 'Kustomerx::Customer'
BillOfMaterialx.task_class = 'EventTaskx::EventTask'
BillOfMaterialx.show_supplier_path = 'supplierx.supplier_path(id: r.supplier_id)'
BillOfMaterialx.quote_index_path = 'in_quotex.quotes_path(:resource_id => r.id, :resource_string => params[:controller])'
BillOfMaterialx.quote_task_index_path = "event_taskx.event_tasks_path(:resource_id => r.id, :resource_string => params[:controller])"
