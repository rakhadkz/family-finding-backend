class UserBlueprint < Blueprinter::Base
  identifier :id

  fields :id,
         :email,
         :first_name,
         :phone,
         :last_name

  view :auth do
    field :token
  end
end
