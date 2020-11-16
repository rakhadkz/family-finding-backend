class Api::V1::ContactsController < ApplicationController
    before_action :authenticate_request!
    before_action :set_contact, only: [:show, :update, :destroy]

    def index
        contacts = Contact.all
        render json: ContactBlueprint.render(contacts)
    end
  
    def show
        render json: ContactBlueprint.render(@contact, root: :data)
    end
  
    def create
        contact = Contact.create!(contact_params)
        render json: ContactBlueprint.render(contact, root: :data)
    end
  
    def update
      @contact.update!(contact_params)
      render json: ContactBlueprint.render(@contact, root: :data)
    end
  
    def destroy
      @contact.destroy
      render status: :ok
    end
  
  
    private

    def set_contact
      @contact = Contact.find(params[:id])
    end

    def contact_params
      params.require(:contact)
          .permit([
                      :first_name,
                      :last_name,
                      :birthday,
                      :address,
                      :address_2,
                      :city,
                      :state,
                      :zip,
                      :email,
                      :phone
                  ])
    end
  
  end