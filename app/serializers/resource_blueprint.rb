class ResourceBlueprint < Blueprinter::Base
    identifier :id
    fields :id, :name, :link, :organization_id, :created_at, :updated_at
end
