class ChildBlueprint < Blueprinter::Base
  identifier :id

  fields :id,
         :first_name,
         :last_name,
         :birthday

  view :siblings do
    field :siblings do |child|
      (child.siblings + child.inverse_siblings).as_json
    end
  end

  view :attachments do
    association :attachments,
                blueprint: AttachmentBlueprint,
                name: :attachments
  end

  view :contacts do
    association :contacts,
                blueprint: ContactBlueprint,
                name: :contacts
  end

  view :extended do

  end

end
