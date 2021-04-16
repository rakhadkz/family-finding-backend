class Api::V1::ChildTreeContactsController < ApplicationController
    before_action :authenticate_request!
  
    def show
      render json: ChildTreeContactBlueprint.render(child_tree_contact, root: :data)
    end
  
    def create
      child_tree_contact = ChildTreeContact.create!(child_tree_contact_params)
      render json: ChildTreeContactBlueprint.render(child_tree_contact, root: :data)
    end
  
    def update
      child_tree_contact.update!(child_tree_contact_params)
      render json: ChildTreeContactBlueprint.render(child_tree_contact, root: :data)
    end
  
    def destroy
      child_tree_contact.destroy!
      head :ok
    end

    private
    def child_tree_contact
      @child_tree_contact ||= ChildTreeContact.find(params[:id])
    end
  
    def child_tree_contact_params
      params.require(:child_tree_contact)
        .permit([
          :child_id,
          :contact_id,
          :relationship,
          :parent_id
        ])
    end
  
  end
  