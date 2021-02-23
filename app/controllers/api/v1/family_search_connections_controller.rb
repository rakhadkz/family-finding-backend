class Api::V1::FamilySearchConnectionsController < ApplicationController
  before_action :authenticate_request!

  def index
    render json: FamilySearchConnectionBlueprint.render(FamilySearchConnection.all, root: :data)
  end

  def show
    render json: FamilySearchConnectionBlueprint.render(family_search_connection, root: :data)
  end

  def create
    family_search_connection = FamilySearchConnection.create!(fs_connection_params)
    render json: FamilySearchConnectionBlueprint.render(family_search_connection, root: :data)
  end

  def update
    family_search_connection.update!(fs_connection_params)
    render json: FamilySearchConnectionBlueprint.render(family_search_connection, root: :data)
  end

  def destroy
    family_search_connection.destroy!
    head :ok
  end

  private
  def family_search_connection
    @family_search_connection ||= FamilySearchConnection.find(params[:id])
  end

  def fs_connection_params
    params
      .require(:family_search_connection)
      .permit([
                :family_search_id,
                :child_contact_id
              ])
  end
end
