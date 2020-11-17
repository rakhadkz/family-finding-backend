class AttachmentBlueprint < Blueprinter::Base
  identifier :id  
  fields :filename, :filetype, :filelocation, :child_id
end