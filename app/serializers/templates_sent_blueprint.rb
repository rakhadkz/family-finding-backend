class TemplatesSentBlueprint < Blueprinter::Base
    identifier :id
    fields :id, :child_contact_id, :communication_template, :content, :opened, :created_at

    association :communication_template, blueprint: CommunicationTemplateBlueprint

    view :extended do
        association :child_contact, blueprint: ChildContactBlueprint
    end
end