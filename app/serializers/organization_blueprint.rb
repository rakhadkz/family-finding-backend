class OrganizationBlueprint < Blueprinter::Base
  identifier :id

  fields :id,
         :name,
         :address,
         :phone,
         :logoUrl,
         :website

end
