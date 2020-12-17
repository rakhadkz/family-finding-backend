class Api::V1::Admin::UsersController < ApplicationController
  include Filterable
  include Searchable
  include Sortable

  before_action :authenticate_request!
  before_action :require_admin

  filterable_by 'users.role'
  sortable_by 'users.first_name', 'users.last_name', 'users.role'

  def index
    results = sort(search(filter(users_scope)))
    users = results.page(params[:page]).per(per_page)
    render json: UserBlueprint.render(users, root: :data, view: view, organization_id: organization, meta: page_info(users))
  end

  def create
    user = User.create!(user_params)
    render json: UserBlueprint.render(user, root: :data)
  end

  def update
    user.update!(user_params)
    render json: UserBlueprint.render(user, root: :data)
  end

  def show
    render json: UserBlueprint.render(user, root: :data, view: :extended, organization_id: organization)
  end

  def destroy
    delete_user
    head :ok
  end

  private

  def users_scope
    if role == "super_admin"
      User.all
    elsif role == "admin"
      Organization.find(organization).users
    else
      nil
    end
  end

  def delete_user
    if role == "super_admin"
      user.user_organizations.destroy_all
    elsif role == "admin"
      user.user_organizations.find_by(organization_id: organization).destroy!
    else
      nil
    end
  end

  def organization
    UserOrganization.filter_by_user_id(@current_user.id).first!.organization_id if role == "admin"
  end

  def role
    UserOrganization.filter_by_user_id(@current_user).first!.role
  end

  def user
    @user ||= User.includes(:organizations).find(params[:id])
  end

  def user_params
    params
      .require(:user)
      .permit(
        [
          :email,
          :role,
          :first_name,
          :last_name,
          :organization_id,
          :phone
        ])
  end

end
