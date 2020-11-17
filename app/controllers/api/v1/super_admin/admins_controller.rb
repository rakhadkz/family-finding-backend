class Api::V1::SuperAdmin::AdminsController < ApplicationController

  include Filterable
  include Searchable
  include Sortable

  before_action :authenticate_request!
  before_action :require_super_admin
  before_action :load_admin, only: %i[
    show
    update
    destroy
  ]


  def index
    results = sort(search(filter(admins_scope)))
    admins = results.page(params[:page]).per(per_page)
    render json: UserBlueprint.render(admins, root: :data, meta: page_info(admins))
  end

  def create
    admin = User.create!(admin_params)
    admin.role = 'admin'
    admin.save!
    render json: UserBlueprint.render(admin, root: :data)
  end

  def update
    @admin.update(admin_params)
    render json: UserBlueprint.render(@admin, root: :data)
  end

  def show
    render json: UserBlueprint.render(@admin, root: :data)
  end

  def destroy
    @admin.destroy!
    render status: :ok
  end

  def admin_params
    params.require(:admin)
        .permit([
                    :email,
                    :first_name,
                    :last_name,
                    :organization_id,
                    :role,
                    :phone
                ])
  end

  def admins_scope
    User.filter_by_role('admin')
  end

  def load_admin
    @admin = User.find(params[:id])
    if !@admin.role === 'admin'
      raise ApiException::Unauthorized
    end
  end


end
