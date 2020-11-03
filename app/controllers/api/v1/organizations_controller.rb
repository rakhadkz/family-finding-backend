class Api::V1::OrganizationsController < ApplicationController
  before_action :set_organization, only: [:show, :update, :destroy]

  # GET /organizations
  def index
    @organizations = Organization.all

    render json: OrganizationBlueprint.render(@organizations)
  end

  # GET /organizations/1
  def show
    render json: OrganizationBlueprint.render(@organization, root: :data)
  end

  # POST /organizations
  def create
    @organization = Organization.new(organization_params)

    if @organization.save
      render json: OrganizationBlueprint.render(@organization, root: :data), status: :created, location: @organization
    else
      render json: @organization.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /organizations/1
  def update
    if @organization.update(organization_params)
      render json: OrganizationBlueprint.render(@organization, root: :data)
    else
      render json: @organization.errors, status: :unprocessable_entity
    end
  end

  # DELETE /organizations/1
  def destroy
    @organization.destroy
    render status: :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organization
      @organization = Organization.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def organization_params
      params.require(:organization).permit(:name, :address, :phone, :logoUrl, :website)
    end
end
