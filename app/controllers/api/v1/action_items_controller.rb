class Api::V1::ActionItemsController < ApplicationController
  include Filterable
  include Searchable
  include Sortable

  before_action :authenticate_request!

  def index
    results = sort(search(filter(@current_user.action_items.active)))
    action_items = results.page(params[:page]).per(per_page)
    render json: ActionItemBlueprint.render(action_items, root: :data, view: view, meta: page_info(action_items))
  end

  def show
    user = User.find_by_id(params[:user_id])
    action_item = user.action_items.active.find_by_id(params[:id])
    render json: ActionItemBlueprint.render(action_item, view: view, root: :data)
  end

  def create
    action_item = ActionItem.create!(action_item_params)
    render json: ActionItemBlueprint.render(action_item, root: :data)
  end

  def update
    action_item.update!(action_item_params)
    render json: ActionItemBlueprint.render(action_item, root: :data)
  end

  def destroy
    action_item.update!(date_removed: DateTime.current) 
    render json: { message: "removed" }, status: :ok
  end

  private

  def action_item
    @action_item ||= ActionItem.includes(:user, :child).find(params[:id])
  end

  def action_item_params
    params
      .require(:action_item)
      .permit(
      [
        :title,
        :description,
        :user_id,
        :child_id
      ])
  end

end
