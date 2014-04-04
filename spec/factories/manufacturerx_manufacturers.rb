# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :manufacturerx_manufacturer, :class => 'Manufacturerx::Manufacturer' do
    name "MyString"
    short_name "MyString"
    contact_info "MyText"
    phone "MyString"
    cell "MyString"
    fax "MyString"
    main_product "MyText"
    active true
    last_updated_by_id 1
    address "MyText"
    quality_system_id 1
  end
end
