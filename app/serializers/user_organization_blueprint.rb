class UserOrganizationBlueprint < Blueprinter::Base
  identifier :id
  fields :id, :user_id, :organization_id, :role

  view :extended do
    association :user, blueprint: UserBlueprint
    association :organization, blueprint: OrganizationBlueprint
  end
end
