class UserBlueprint < Blueprinter::Base
  identifier :id

  fields :id

  view :sidebar_profile do
    fields :first_name, :last_name, :ava
  end

  view :extended do
    field :organization_id, default: "N/A"
    fields :id,
           :email,
           :first_name,
           :phone,
           :last_name,
           :role
    association :organization, blueprint: OrganizationBlueprint, default: "N/A"
  end

  view :auth do
    field :token
  end
end
