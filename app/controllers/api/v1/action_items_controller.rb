class Api::V1::ActionItemsController < ApplicationController
  include Filterable
  include Searchable
  include Sortable

  before_action :authenticate_request!

  def index
    results = sort(search(filter(ActionItem.all)))
    action_items = results.page(params[:page]).per(per_page)
    render json: ActionItemBlueprint.render(action_items, root: :data, view: view, meta: page_info(action_items))
  end

  def show
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
    action_item.destroy!
    head :ok
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
        :priority_level,
        :status,
        :user_id,
        :child_id
      ])
  end

end
