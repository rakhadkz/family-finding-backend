class FamilySearchAttachmentBlueprint < Blueprinter::Base
  identifier :id
  fields :id, :family_search_id, :attachment_id
  association :attachment, blueprint: AttachmentBlueprint
end
