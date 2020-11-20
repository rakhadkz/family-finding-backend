class Api::V1::SuperAdmin::OrganizationsController < ApplicationController
  before_action :authenticate_request!
  before_action :require_super_admin

  def index
    organizations = Organization.all
    render json: OrganizationBlueprint.render(organizations, view: view, root: :data)
  end

  def show
    render json: OrganizationBlueprint.render(organization, root: :data)
  end

  def create
    params[:organization][:phone] = TwilioPhone.format(organization_params)
    organization = Organization.create!(organization_params)
    render json: OrganizationBlueprint.render(organization, root: :data)
  end

  def update
    params[:organization][:phone] = TwilioPhone.format(organization_params)
    organization.update!(organization_params)
    render json: OrganizationBlueprint.render(organization, root: :data)
  end

  def destroy
    organization.destroy!
    head :ok
  end

  private
    def organization
      @organization ||= Organization.find(params[:id])
    end

    def organization_params
      params.require(:organization).permit(
        [
          :name, 
          :address, 
          :phone, 
          :logo, 
          :website, 
          :state, 
          :zip, 
          :city
        ])
    end

end
