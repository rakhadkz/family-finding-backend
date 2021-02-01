class Api::V1::UserChildrenController < ApplicationController

  before_action :authenticate_request!

  def index
    render json: UserChildBlueprint.render(UserChild.all, root: :data)
  end

  def create
    user_children = []
    user_children.push UserChild.create!(user_child_params.except(:users)) if user_child_params[:user_id].present?
    user_child_params[:users].each do |record|
      user_child = UserChild.find_by(child_id: record[:child_id], user_id: record[:user_id])
      if user_child.nil?
        user_children.push UserChild.create!(record)
      else
        user_child.update!(record)
      end
    end if user_child_params[:users].present?
    render json: UserChildBlueprint.render(user_children, root: :data)
  end

  def update
    user_child = UserChild.find_by user_id: user_child_params[:user_id], child_id: user_child_params[:child_id]
    user_child.update!(user_child_params)
    render json: user_child
  end

  def destroy
    user_child.destroy!
    render json: { status: "deleted" }, status: :ok
  end

  private
  def user_child_params
    params
      .require(:user_child)
      .permit(
        :user_id, :child_id, :date_approved, :date_denied,
        users: [:user_id, :child_id, :date_approved, :date_denied]
      )
  end

  def user_child
    @user_child ||= UserChild.find(params[:id])
  end
end
