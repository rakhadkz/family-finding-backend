class Api::V1::ChildrenController < ApplicationController
  include Filterable
  include Searchable
  include Sortable

  before_action :authenticate_request!
  before_action :require_user

  before_action :set_child, only: [:show, :update, :destroy]

  sortable_by 'children.first_name', 'children.last_name', 'children.birthday'

  def index
    results = sort(search(filter(children_scope)))
    @children = results.page(params[:page]).per(per_page)
    render json: ChildBlueprint.render(@children, root: :data)
  end

  def show
    render json: ChildBlueprint.render(@child, root: :data)
  end

  def create
    child = Child.create!(child_params)
    render json: ChildBlueprint.render(child, root: :data)
  end

  def update
    @child.update!(child_params)
    render json: ChildBlueprint.render(@child, root: :data)
  end

  def destroy
    @child.destroy
    head :ok
  end

  private

    def children_scope
      Child.all
    end

    def set_child
      @child = Child.find(params[:id])
    end

    def child_params
      params.require(:child).permit(:first_name, :last_name, :birthday)
    end
end
