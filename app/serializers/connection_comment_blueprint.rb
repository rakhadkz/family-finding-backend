class ConnectionCommentBlueprint < Blueprinter::Base
  identifier :id
  fields :id, :child_contact_id, :comment_id
end
