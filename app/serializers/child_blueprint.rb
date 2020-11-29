class ChildBlueprint < Blueprinter::Base
  identifier :id
  fields :id, :first_name, :last_name, :birthday, :permanency_goal, :continuous_search

  view :siblings do
    association :all_siblings, blueprint: ChildBlueprint, name: :siblings
  end
  
  view :attachments do
    association :attachments, blueprint: AttachmentBlueprint, view: :extended,     name: :attachments
  end

  view :contacts do
    association :contacts, blueprint: ContactBlueprint, name: :contacts
  end

  view :table do
    excludes :first_name, :last_name
    field :full_name do |child|
      "#{child.first_name} #{child.last_name}"
    end
    field :days_in_system do |child|
      ((Time.now - child.created_at) / 86400).to_i
    end
    field :permanency_goal, default: "Return To Parent"
    field :relatives do |child|
      child.contacts.count
    end
    field :matches do |child|
      child.findings.count
    end
  end

  view :comments do
    excludes :birthday, :continuous_search, :first_name, :last_name, :permanency_goal
    association :comments, blueprint: CommentBlueprint, view: :extended
  end
end