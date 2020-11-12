class Api::V1::SuperAdmin::OrganizationsController < ApplicationController
  include Filterable
  include Searchable
  include Sortable

  before_action :authenticate_request!
  before_action :set_view, only: [:index]
  before_action :require_super_admin
  before_action :set_organization, only: [:show, :update, :destroy]

  # GET /organizations

  def index
    results = sort(search(filter(organizations_scope)))
    organizations = results.page(params[:page]).per(per_page)
    render json: OrganizationBlueprint.render(organizations, view: @view, root: :data,  meta: page_info(organizations))
  end

  def show
    render json: OrganizationBlueprint.render(@organization, root: :data)
  end

  def create
    organization = Organization.create!(organization_params)
    render json: OrganizationBlueprint.render(organization, root: :data)
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
      params.require(:organization).permit(:name, :address, :phone, :logo, :website, :state, :zip, :city)
    end

  def organizations_scope
    Organization.all
  end
end
