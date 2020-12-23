class OrganizationBlueprint < Blueprinter::Base
  identifier :id
  fields :id, :name, :address, :state, :city, :zip, :phone, :logo, :website

  view :short do
    excludes :address, :state, :city, :zip, :phone, :logo, :website
  end

  view :extended do
    association :users, blueprint: UserBlueprint
  end
end
