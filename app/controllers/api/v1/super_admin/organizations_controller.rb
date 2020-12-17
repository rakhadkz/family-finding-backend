class Api::V1::SuperAdmin::OrganizationsController < ApplicationController
  include Filterable
  include Searchable
  include Sortable

  before_action :authenticate_request!
  before_action :require_super_admin

  sortable_by 'organizations.name', 'organizations.address', 'organizations.state', 'organizations.city'

  def index
    results = sort(search(filter(Organization.all)))
    organizations = results.page(params[:page]).per(per_page)
    render json: OrganizationBlueprint.render(organizations, root: :data, view: view, meta: page_info(organizations))
  end

  def show
    render json: OrganizationBlueprint.render(organization, root: :data)
  end

  def create
    params[:organization][:phone] = TwilioPhone.format(organization_params) if params[:organization][:phone]
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
