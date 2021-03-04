class OrganizationBlueprint < Blueprinter::Base
  identifier :id
  fields :id, :name, :address, :state, :city, :zip, :phone, :logo, :website

  view :short do
    excludes :address, :state, :city, :zip, :phone, :website
  end

  view :extended do
    association :users, blueprint: UserBlueprint
    association :twilio_phone_number, blueprint: TwilioPhoneNumberBlueprint
  end
end
