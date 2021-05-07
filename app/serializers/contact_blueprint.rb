class ContactBlueprint < Blueprinter::Base
  identifier :id
  fields :first_name, :last_name, :relationship, :birthday, :city, :state, :zip, :email, :phone, :race, :sex, :address_id, :access_to_transportation, :verified_employment
  association :communications, blueprint: CommunicationBlueprint
  association :address, blueprint: AddressBlueprint

  view :extended do
    association :child_contacts, blueprint: ChildContactBlueprint, view: :children
  end
end
  