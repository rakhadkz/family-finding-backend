class Api::V1::ContactsController < ApplicationController
  include Filterable
  include Searchable
  include Sortable

  before_action :authenticate_request!

  def index
    contacts = sort(search(filter(contact_scope)))
    render json: ContactBlueprint.render(contacts, view: view, root: :data)
  end

  def show
    render json: ContactBlueprint.render(contact, root: :data)
  end

  def create
    contact = Contact.create!(contact_params)
    render json: ContactBlueprint.render(contact, root: :data)
  end

  def update
    contact.update!(contact_params)
    render json: ContactBlueprint.render(contact, root: :data)
  end

  def destroy
    contact.destroy!
    head :ok
  end

  private

  def contact
    @contact ||= Contact.find(params[:id])
  end

  def contact_scope
    if params[:first_name] && params[:last_name]
      contacts = Contact.where(first_name: params[:first_name], last_name:params[:last_name])
    else
      contacts = Contact.all
    end
  end

  def contact_params
    params.require(:contact)
      .permit([
        :first_name,
        :last_name,
        :relationship,
        :birthday,
        :city,
        :state,
        :zip,
        :email,
        :phone,
        :parent_id,
        :race,
        :sex,
        :access_to_transportation,
        :verified_employment
      ])
  end
  
end
