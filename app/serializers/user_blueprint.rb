class UserBlueprint < Blueprinter::Base
  identifier :id

  fields :id,
         :email,
         :first_name,
         :last_name

  view :auth do
    field :token
  end
end
