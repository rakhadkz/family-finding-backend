class Api::V1::ActionItemsController < ApplicationController
  before_action :authenticate_request!

  def index
    action_items = ActionItem.all
    render json: ActionItemBlueprint.render(action_items, view: view, root: :data)
  end

  def show
    render json: ActionItemBlueprint.render(action_item, view: view, root: :data)
  end

  def create
    action_item = ActionItem.create!(action_item_params)
    render json: ActionItem.render(action_item, root: :data)
  end

  def update
    action_item.update!(action_item_params)
    render json: ActionItem.render(action_item, root: :data)
  end

  def destroy
    action_item.destroy!
    head :ok
  end

  private

  def action_item
    @action_item ||= ActionItem.include(:user, :child).find(params[:id])
  end

  def action_item_params
    params
      .require(:action_item)
      .permit(
      [
        :title,
        :description,
        :priority_level,
        :status,
        :user_id,
        :child_id
      ])
  end

end
