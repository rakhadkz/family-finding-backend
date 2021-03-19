class ContactBlueprint < Blueprinter::Base
  identifier :id
  fields :first_name, :last_name,:relationship, :birthday, :address, :address_2, :city, :state, :zip, :email, :phone, :race, :sex
  association :communications, blueprint: CommunicationBlueprint
end
  