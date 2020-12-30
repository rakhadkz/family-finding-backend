class ChildBlueprint < Blueprinter::Base
  identifier :id
  fields :id, :first_name, :last_name, :birthday, :permanency_goal, :continuous_search

  view :siblings do
    association :all_siblings, blueprint: ChildBlueprint, name: :siblings
  end
  
  view :attachments do
    association :attachments, blueprint: AttachmentBlueprint, view: :extended, name: :attachments
  end

  view :contacts do
    association :child_contacts, blueprint: ChildContactBlueprint, view: :extended, name: :contacts
  end

  view :family_tree do
    association :child_tree_contacts, blueprint: ChildTreeContactBlueprint, view: :extended, name: :family_tree
  end

  view :not_child_users do
    association :users, blueprint: UserBlueprint, name: :not_child_users do |child, options|
      options[:user].organization_users(:user) - child.users
    end
  end

  view :child_users do
    association :users, blueprint: UserBlueprint, name: :child_users
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
    include_view :contacts
    include_view :comments
    include_view :attachments
    include_view :family_tree
    field :birthday do
      "14/10/2001"
    end
    field :gender do
      "Male"
    end
    field :race do
      "White"
    end
    field :system_status do
      "In searching"
    end
  end

  view :users do
    include_view :not_child_users
    include_view :child_users
  end
end
