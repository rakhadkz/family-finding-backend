class UserBlueprint < Blueprinter::Base
  identifier :id
  fields :id, :email, :first_name, :phone, :last_name, :role, :organization_id

  view :sidebar_profile do
    excludes :id, :email, :first_name, :phone, :last_name
    field :ava
    field :name do |user|
      "#{user.first_name} #{user.last_name}"
    end
  end

  view :extended do
    association :user_organizations, blueprint: UserOrganizationBlueprint, view: :short, default: [] do |user, options|
      if options[:organization_id]
        user.user_organizations.filter_by_organization_id(options[:organization_id]).order(id: :asc)
      else
        user.user_organizations.order(id: :asc)
      end
    end
  end

  view :auth do
    field :token
  end
end
