class UserBlueprint < Blueprinter::Base
  identifier :id

  fields :id,
         :email,
         :first_name,
         :phone,
         :last_name,
          :organization_id,
          :role

  view :short do

  end

  view :extended do
    association :organization, blueprint: OrganizationBlueprint
  end

  view :auth do
    field :token
  end
end
