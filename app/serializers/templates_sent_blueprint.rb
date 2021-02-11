class TemplatesSentBlueprint < Blueprinter::Base
    identifier :id
    fields :contact, :communication_template, :content, :opened, :created_at

    association :contact, blueprint: ContactBlueprint
    association :communication_template, blueprint: CommunicationTemplateBlueprint
end