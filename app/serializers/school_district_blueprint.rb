class SchoolDistrictBlueprint < Blueprinter::Base
  identifier :id
  fields :id, :name, :address_id

  association :address, blueprint: AddressBlueprint

end
