class SendgridDomainBlueprint < Blueprinter::Base
    identifier :id
    fields :domain_id, :organization_id
end