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
  end

  view :comments do

    association :comments, blueprint: CommentBlueprint, view: :extended
  end

  view :extended do
    include_view :contacts
    include_view :comments
    include_view :attachments
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
end
