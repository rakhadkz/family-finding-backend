class UserBlueprint < Blueprinter::Base
  identifier :id
  fields :id, :email, :first_name, :phone, :last_name, :role, :organization_id
  association :organization, blueprint: OrganizationBlueprint, view: :short
  view :sidebar_profile do
    excludes :id, :email, :first_name, :phone, :last_name
    field :ava
    field :name do |user|
      "#{user.first_name} #{user.last_name}"
    end
  end

  view :table do
    association :user_organizations, blueprint: UserOrganizationBlueprint, view: :short, default: []
  end

  view :extended do
    association :user_organizations, blueprint: UserOrganizationBlueprint, view: :short, default: []
  end

  view :auth do
    field :token
  end
end
