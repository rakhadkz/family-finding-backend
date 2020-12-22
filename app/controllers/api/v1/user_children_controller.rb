class Api::V1::UserChildrenController < ApplicationController

  def index
    render json: UserChildBlueprint.render(UserChild.all, root: :data)
  end

  def create
    user_children = []
    user_child_params[:users].each do |record|
      user_children.push UserChild.create!(record)
    end
    render json: UserChildBlueprint.render(user_children, root: :data)
  end

  def user_child_params
    params
      .require(:user_child)
      .permit(
        users: [:user_id, :child_id, :date_approved, :date_denied]
      )
  end
end
