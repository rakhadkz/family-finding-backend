class OrganizationBlueprint < Blueprinter::Base
  identifier :id

  fields :id, :name

  view :short do

  end

  view :extended do
    include_view :short
    fields :address,
           :state,
           :city,
           :zip,
        :phone,
        :logo,
        :website
  end

end
