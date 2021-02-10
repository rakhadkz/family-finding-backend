class Api::V1::ChildContactsController < ApplicationController
  before_action :authenticate_request!

  def show
    render json: ChildContactBlueprint.render(child_contact, root: :data)
  end

  def create
    child_contact = ChildContact.create!(child_contact_params)
    render json: ChildContactBlueprint.render(child_contact, root: :data)
  end

  def update
    child_contact.update!(child_contact_params)
    render json: ChildContactBlueprint.render(child_contact, root: :data)
  end

  def destroy
    child_contact.destroy!
    head :ok
  end

  private
  def child_contact
    @child_contact ||= ChildContact.find(params[:id])
  end

  def child_contact_params
    params.require(:child_contact)
      .permit([
        :child_id,
        :contact_id,
        :relationship,
        :parent_id,
        :family_fit_score,
        :potential_match,
        :is_confirmed,
        :is_disqualified,
        :is_placed
      ])
  end

end
