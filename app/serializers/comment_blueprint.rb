class ContactBlueprint < Blueprinter::Base
    identifier :id

    fields :title, :body, :in_reply_to, :user_id
  end
    