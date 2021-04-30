class CommunicationBlueprint < Blueprinter::Base
    identifier :id
    fields :id, :communication_type, :value, :is_current
  end
  