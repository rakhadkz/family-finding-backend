class Api::V1::SuperAdmin::OrganizationsController < ApplicationController
  include Filterable
  include Searchable
  include Sortable

  before_action :authenticate_request!
  before_action :require_super_admin

  def index
    results = sort(search(filter(organizations_scope)))
    organizations = results.page(params[:page]).per(per_page)
    render json: OrganizationBlueprint.render(organizations, view: view, root: :data,  meta: page_info(organizations))
  end

  def show
    render json: OrganizationBlueprint.render(organization, root: :data, view: view)
  end

  def create
    params[:organization].each { |key, value| value.strip! if value.is_a? String }
    params[:organization][:phone] = TwilioPhone.new(organization_params).call
    organization = Organization.create!(organization_params)
    render json: OrganizationBlueprint.render(organization, root: :data)
  end

  def update
    params[:organization].each { |key, value| value.strip! if value.is_a? String }
    params[:organization][:phone] = TwilioPhone.new(organization_params).format
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

    def organizations_scope
      Organization.all
    end
end
