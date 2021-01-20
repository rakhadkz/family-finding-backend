class CommunicationTemplateBlueprint < Blueprinter::Base
  identifier :id
  fields :id, :name, :content, :template_type, :organization_id, :created_at, :updated_at

end
