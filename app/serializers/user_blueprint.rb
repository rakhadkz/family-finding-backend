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

  view :table do
    association :user_organizations, blueprint: UserOrganizationBlueprint, view: :short, default: [] do |user, options|
      if %w[user admin manager].include? options[:user].role
        user.user_organizations.filter_by_organization_id(options[:user].organization_id)
      else
        user.user_organizations
      end
    end
  end

  view :extended do
    association :user_organizations, blueprint: UserOrganizationBlueprint, view: :short, default: []
  end

  view :auth do
    field :token
  end
end
