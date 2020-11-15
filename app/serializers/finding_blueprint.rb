class FindingBlueprint < Blueprinter::Base
  identifier :id

  fields :id,
         :child_id,
         :search_vector_id,
         :user_id,
         :description

  view :short do

  end

  view :extended do
    excludes :search_vector_id, :user_id, :child_id
    association :user, blueprint: UserBlueprint, view: :extended
    association :child, blueprint: ChildBlueprint
    association :search_vector, blueprint: SearchVectorBlueprint
    association :attachments, blueprint: AttachmentBlueprint, name: :attachments
  end

  view :attachments do
    association :attachments,
                blueprint: AttachmentBlueprint,
                name: :attachments
  end
end
