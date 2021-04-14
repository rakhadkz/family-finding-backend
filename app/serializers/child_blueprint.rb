class ChildBlueprint < Blueprinter::Base
  identifier :id
  fields :id, :first_name, :last_name, :birthday, :permanency_goal, :continuous_search, :system_status, :school_district_id

  view :siblings do
    association :all_siblings, blueprint: ChildBlueprint, name: :siblings
  end
  
  view :attachments do
    association :child_attachments, blueprint: ChildAttachmentBlueprint, view: :extended, name: :attachments
  end

  view :contacts do
    association :child_contacts, blueprint: ChildContactBlueprint, view: :extended, name: :contacts
  end

  view :family_tree do
    association :child_tree_contacts, blueprint: ChildTreeContactBlueprint, view: :extended, name: :family_tree
  end

  view :family_searches do
    association :family_searches, blueprint: FamilySearchBlueprint
  end

  view :not_child_users do
    association :users, blueprint: UserBlueprint, name: :not_child_users do |child, options|
      options[:user].organization_users(:user) - child.users
    end
  end

  view :child_users do
    # association :users, blueprint: UserBlueprint, name: :child_users
    association :user_children, blueprint: UserChildBlueprint, name: :child_users
  end

  view :table do
    excludes :first_name, :last_name
    field :full_name do |child|
      "#{child.first_name} #{child.last_name}"
    end
    field :days_in_system do |child|
      ((Time.now - child.created_at) / 86400).to_i
    end
    field :continuous_search, default: "ON"
    field :permanency_goal, default: "Return To Parent"
    field :relatives do |child|
      child.contacts.count
    end
    field :matches do |child|
      child.findings.count
    end
    field :user_request do |child, options|
      UserChild.find_by(user_id: options[:user].id, child_id: child.id).as_json
    end
  end

  view :comments do
    association :comments, blueprint: CommentBlueprint, view: :extended
  end

  view :extended do
    field :gender, default: :Undefined
    field :race, default: :Undefined
    field :system_status, default: :Inactive
    field :request_pending, default: false
  end

  view :users do
    include_view :not_child_users
    include_view :child_users
  end
end
