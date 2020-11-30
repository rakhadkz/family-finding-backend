class Api::V1::UserOrganizationsController < ApplicationController
  before_action :authenticate_request!

  def index
    user_organizations = UserOrganization.includes(:user, :organization).all
    render json: UserOrganizationBlueprint.render(user_organizations, view: view, root: :data)
  end

  def show
    render json: UserOrganizationBlueprint.render(user_organization, view: view, root: :data)
  end

  def create
    user_organization = UserOrganization.create!(user_organization_params)
    render json: UserOrganizationBlueprint.render(user_organization, root: :data)
  end

  def update
    user_organization.update!(user_organization_params)
    render json: UserOrganizationBlueprint.render(user_organization, root: :data)
  end

  def destroy
    user_organization.destroy!
    head :ok
  end

  private
  def user_organization
    @user_organization ||= UserOrganization.includes(:user, :organization).find(params[:id])
  end

  def user_organization_params
    params.require(:user_organization)
      .permit([
        :user_id,
        :organization_id
      ])
  end
end
