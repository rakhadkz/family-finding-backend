class TwilioPhoneNumberBlueprint < Blueprinter::Base
    identifier :id
    fields :phone, :friendly_name, :phone_sid, :organization_id
end