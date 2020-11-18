class OrganizationBlueprint < Blueprinter::Base
  identifier :id
  fields :id, :name

  view :extended do
    fields :address, :state, :city, :zip, :phone, :logo, :website
  end
end
