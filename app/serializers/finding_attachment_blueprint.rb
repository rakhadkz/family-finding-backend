class FindingAttachmentBlueprint < Blueprinter::Base
  identifier :id

  fields :id,
         :finding_id,
         :attachment_id

  view :short do

  end

  view :extended do
    excludes :finding_id, :attachment_id
    association :attachment, blueprint: AttachmentBlueprint
  end

end
