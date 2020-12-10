class Api::V1::ChildrenController < ApplicationController
  include Filterable
  include Searchable
  include Sortable

  before_action :authenticate_request!

  def index
    results = sort(search(filter(Child.all)))
    children = results.page(params[:page]).per(per_page)
    render json: ChildBlueprint.render(children, root: :data, view: view, meta: page_info(children))
  end

  def show
    render json: ChildBlueprint.render(child, view: view, root: :data)
  end

  def create
    child = Child.create!(child_params)
    render json: ChildBlueprint.render(child, root: :data)
  end

  def update
    child.update!(child_params)
    render json: ChildBlueprint.render(child, root: :data)
  end

  def destroy
    child.destroy!
    head :ok
  end

  private

  def child
    @child ||= Child.includes(:child_contacts, :contacts).find(params[:id])
  end

  def child_params
    params.require(:child).permit(:first_name, :last_name, :birthday, :permanency_goal)
  end

end
