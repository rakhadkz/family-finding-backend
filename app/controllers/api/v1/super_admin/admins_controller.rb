class Api::V1::SuperAdmin::AdminsController < ApplicationController
  include Searchable
  include Sortable

  before_action :authenticate_request!
  before_action :require_super_admin

  sortable_by 'users.first_name', 'users.last_name'

  def index
    results = sort(search(admins_scope))
    admins = results.page(params[:page]).per(per_page)
    render json: UserBlueprint.render(admins, root: :data, view: :extended, meta: page_info(admins))
  end

  def create
    admin = User.create!(admin_params)
    admin.role = 'admin'
    admin.save!
    render json: UserBlueprint.render(admin, root: :data)
  end

  def update
    admin.update!(admin_params)
    render json: UserBlueprint.render(admin, root: :data, view: :extended)
  end

  def show
    render json: UserBlueprint.render(admin, root: :data, view: :extended)
  end

  def destroy
    admin.destroy!
    head :ok
  end

  private

  def admin_params
    params.require(:admin)
      .permit(
        [
          :email,
          :first_name,
          :last_name,
          :organization_id,
          :role,
          :phone
        ])
  end

  def admins_scope
    User.filter_by_role(:admin)
  end

  def admin
    @admin ||= User.admin.find(params[:id])
  end

end
