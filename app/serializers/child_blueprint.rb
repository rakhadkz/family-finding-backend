class ChildBlueprint < Blueprinter::Base
  identifier :id
  fields :id, :first_name, :last_name, :birthday

  view :siblings do
    association :all_siblings, blueprint: ChildBlueprint, name: :siblings
  end
  
  view :attachments do
    association :attachments, blueprint: AttachmentBlueprint, name: :attachments
  end

  view :contacts do
    association :contacts, blueprint: ContactBlueprint, name: :contacts
  end
end