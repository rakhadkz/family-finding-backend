class Api::V1::CommunicationsController < ApplicationController
  before_action :authenticate_request!

  def show
    render json: CommunicationBlueprint.render(communication, root: :data)
  end

  def create
    item = Communication.create!(communication_params)
    render json: CommunicationBlueprint.render(item, root: :data)
  end

  def update
    communication.update!(communication_params)
    render json: CommunicationBlueprint.render(communication, root: :data)
  end

  def destroy
    communication.destroy!
    head :ok
  end

  private
  def communication
    @communication ||= Communication.find(params[:id])
  end

  def communication_params
    params.require(:communication)
      .permit([
                :communication_type,
                :value,
                :contact_id
              ])
  end
end
