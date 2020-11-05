class Api::V1::SuperAdmin::OrganizationAdminsController < ApplicationController

  include Filterable
  include Searchable
  include Sortable

  before_action :authenticate_request!
  before_action :require_super_admin
  before_action :load_organization_admin, only: %i[
    show
    update
    destroy
  ]


  def index
    results = sort(search(filter(organization_admins_scope)))
    organization_admins = results.page(params[:page]).per(per_page)
    render json: UserBlueprint.render(organization_admins, root: :data, meta: page_info(organization_admins))
  end

  def create
    organization_admin = User.create!(organization_admin_params)
    organization_admin.role = 'organization_admin'
    if organization_admin.save
      render json: UserBlueprint.render(organization_admin, root: :data)
    else
      render json: organization_admin.errors, status: :unprocessable_entity
    end
  end

  def update
    @organization_admin.update(organization_admin_params)
    render json: UserBlueprint.render(@organization_admin, root: :data)
  end

  def show
    render json: UserBlueprint.render(@organization_admin, root: :data)
  end

  def destroy
    @organization_admin.destroy
    render status: :ok
  end

  def organization_admin_params
    params.require(:organization_admin)
        .permit([
                    :email,
                    :first_name,
                    :last_name
                ])
  end

  def organization_admins_scope
    User.filter_by_role('organization_admin')
  end

  def load_organization_admin
    @organization_admin = User.find(params[:id])
    if !@organization_admin.role === 'organization_admin'
      raise ApiException::Unauthorized
    end
  end


end
