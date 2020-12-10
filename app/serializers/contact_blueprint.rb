class ContactBlueprint < Blueprinter::Base
  identifier :id
  fields :first_name, :last_name, :birthday, :address, :address_2, :city, :state, :zip, :email, :phone

end
  