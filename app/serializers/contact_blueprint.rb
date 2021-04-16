class ContactBlueprint < Blueprinter::Base
  identifier :id
  fields :first_name, :last_name, :relationship, :birthday, :city, :state, :zip, :email, :phone, :race, :sex, :address_id
  association :communications, blueprint: CommunicationBlueprint
  association :address, blueprint: AddressBlueprint
end
  