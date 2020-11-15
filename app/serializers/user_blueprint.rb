class UserBlueprint < Blueprinter::Base
  identifier :id

  fields :id,
         :email,
         :first_name,
         :phone,
         :last_name,
         :role

  view :sidebar_profile do
    excludes :id,
           :email,
           :first_name,
           :phone,
           :last_name,
           :role
    field :ava
    field :name do |user|
      "#{user.first_name} #{user.last_name}"
    end
  end

  view :extended do
    field :organization_id, default: "N/A"
    association :organization, blueprint: OrganizationBlueprint, default: "N/A"
  end

  view :auth do
    field :token
  end
end
